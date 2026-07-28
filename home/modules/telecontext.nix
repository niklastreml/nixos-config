{ ... }:
{
  # telecontext MCP server. Import this module on hosts that should have it
  # (e.g. work machines); it wires the server into both opencode and pi.
  programs.opencode.settings.mcp.telecontext = {
    type = "remote";
    url = "https://telecontext.telekom.de/mcp";
  };
    #piMcpServers.telecontext.url = "https://telecontext.telekom.de/mcp";
}
