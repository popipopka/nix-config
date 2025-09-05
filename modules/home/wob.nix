{ ... }:
{
  services.wob = {
    enable = true;
    settings = {
      "" = {
  		anchor = "bottom";
        width = 170;
        height = 15;
        border_size = 1;
        border_offset = 0;
 	    margin = "0 0 50 0"; 
 	    bar_padding = 2;
 	    timeout = 800;
      };
    };
  };
}
