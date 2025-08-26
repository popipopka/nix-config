{ pkgs, ... }:
{
  programs.btop = {
    enable = true;

    package = pkgs.btop.override {
      rocmSupport = true;
      cudaSupport = true;
    };

    settings = {
      rounded_corners = true;
      proc_tree = true;
      show_gpu_info = "on";
      show_uptime = true;
      show_coretemp = true;
      show_disks = true;
      cpu_sensor = "auto";
      only_physical = true;
      io_mode = true;
      io_graph_combined = false;
    };
  };
}
