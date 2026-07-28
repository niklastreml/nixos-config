{ pkgs, ... }:

let
  setup-eduroam = pkgs.writeShellApplication {
    name = "setup-eduroam";

    runtimeInputs = with pkgs; [
      openssl
      networkmanager
      gnused
    ];

    text = ''
      if [ "$EUID" -ne 0 ]; then
        echo "Error: Please run this script as root (e.g., using sudo)."
        exit 1
      fi

      if [ "$#" -ne 1 ]; then
        echo "Usage: setup-eduroam <path-to-p12-file>"
        echo "Example: sudo setup-eduroam /home/user/Downloads/easyroam.p12"
        exit 1
      fi

      P12_FILE="$1"

      # FIX 1: Move certificates into iwd's systemd-approved state directory
      CERT_DIR="/var/lib/iwd/eduroam-certs"

      if [ ! -f "$P12_FILE" ]; then
        echo "Error: Certificate file '$P12_FILE' not found."
        exit 1
      fi

      echo "Creating secure directory at $CERT_DIR..."
      mkdir -p "$CERT_DIR"
      chmod 700 "$CERT_DIR"

      echo "Extracting client certificate..."
      openssl pkcs12 -in "$P12_FILE" -clcerts -nokeys -out "$CERT_DIR/cert.pem" -legacy -passin pass:

      echo "Extracting and cleaning private key..."
      # FIX 2: Pipe through 'openssl pkey' to strip bag attributes that crash iwd
      openssl pkcs12 -in "$P12_FILE" -nocerts -nodes -legacy -passin pass: | openssl pkey -out "$CERT_DIR/private.key"

      echo "Extracting CA certificate..."
      openssl pkcs12 -in "$P12_FILE" -cacerts -nokeys -out "$CERT_DIR/ca.pem" -legacy -passin pass:

      echo "Setting strict file permissions..."
      chmod 600 "$CERT_DIR/private.key"
      chmod 644 "$CERT_DIR/cert.pem" "$CERT_DIR/ca.pem"

      echo "Extracting exact easyroam identity..."
      IDENTITY=$(openssl x509 -in "$CERT_DIR/cert.pem" -noout -subject | sed -n 's/.*CN\s*=\s*\([^,]*\).*/\1/p')
      IDENTITY=$(echo "$IDENTITY" | xargs)

      if [ -z "$IDENTITY" ]; then
        echo "Error: Could not extract identity from certificate."
        exit 1
      fi

      echo "Identity detected: $IDENTITY"

      echo "Clearing existing eduroam profiles (if any)..."
      nmcli connection delete eduroam 2>/dev/null || true

      # Clear any orphaned iwd profiles NetworkManager might have left behind
      rm -f /var/lib/iwd/eduroam.8021x 2>/dev/null || true

      echo "Adding new eduroam profile..."
      nmcli connection add \
        type wifi \
        con-name "eduroam" \
        ssid "eduroam" \
        wifi-sec.key-mgmt wpa-eap \
        802-1x.eap tls \
        802-1x.identity "$IDENTITY" \
        802-1x.client-cert "$CERT_DIR/cert.pem" \
        802-1x.private-key "$CERT_DIR/private.key" \
        802-1x.ca-cert "$CERT_DIR/ca.pem"

      echo "Restarting iwd to clear bad state..."
      systemctl restart iwd

      # Wait a moment for iwd to come back up before asking NM to connect
      sleep 2

      echo "Activating eduroam connection..."
      nmcli connection up eduroam

      echo "Setup complete."
    '';
  };
in
{
  home.packages = [
    setup-eduroam
  ];
}
