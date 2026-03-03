{ config, lib, pkgs, ... }:
with lib;
let 
  cfg = config.myHome.media.nom;
in
{
  options.myHome.media.nom = {
    enable = lib.mkEnableOption "Enable the nom rss feed reader.";
  };

  config = mkIf cfg.enable {
    home.packages = [
      pkgs.unstable.nom
    ];

    xdg.configFile."nom/config.yml" = {
      force = true;
      text = lib.generators.toYAML {} {
        autoread = true;
        showread = false;
        ordering = "desc";

        openers = [
          { regex = "youtube";  cmd = "mpv %s"; }
        ];

        theme = {
          glamour = "dark";
          titleColor = "#${config.lib.stylix.colors.base0D-hex}";
          titleColorFg = "#${config.lib.stylix.colors.base07-hex}";
          filterColor = "#${config.lib.stylix.colors.base0D-hex}";
          selectedItemColor = "#${config.lib.stylix.colors.base0D-hex}";
        };

        filtering = {
          defaultIncludeFeedName = true;
        };
        
        feeds = [
          # Music
          { name = "Adam Neely"; url = "https://www.youtube.com/feeds/videos.xml?channel_id=UCnkp4xDOwqqJD7sSM3xdUiQ"; }    
          { name = "Tantacrul"; url = "https://www.youtube.com/feeds/videos.xml?channel_id=UCl_dlV_7ofr4qeP1drJQ-qg"; }      

          # Tech
          { name = "Code Bullet"; url = "https://www.youtube.com/feeds/videos.xml?channel_id=UC0e3QhIYukixgh5VVpKHH9Q"; }    

          { name = "Action Retro"; url = "https://www.youtube.com/feeds/videos.xml?channel_id=UCoL8olX-259lS1N6QPyP4IQ"; }    
          { name = "Explaining Computers"; url = "https://www.youtube.com/feeds/videos.xml?channel_id=UCbiGcwDWZjz05njNPrJU7jA"; }    
          { name = "This Does Not Compute"; url = "https://www.youtube.com/feeds/videos.xml?channel_id=UCEp20NgOZHmgWdbQdHSxgjw"; }    
          { name = "Jeff Geerling"; url = "https://www.youtube.com/feeds/videos.xml?channel_id=UCR-DXc1voovS8nhAvccRZhg"; }    

          { name = "TechLinked"; url = "https://www.youtube.com/feeds/videos.xml?channel_id=UCeeFfhMcJa1kjtfZAGskOCA"; }    

          { name = "Dankpods"; url = "https://www.youtube.com/feeds/videos.xml?channel_id=UC7Jwj9fkrf1adN4fMmTkpug"; }      

          ## Linux
          { name = "The Linux Experiment"; url = "https://www.youtube.com/feeds/videos.xml?channel_id=UC5UAwBUum7CPN5buc-_N1Fw"; }    
          { name = "Mental Outlaw"; url = "https://www.youtube.com/feeds/videos.xml?channel_id=UC7YOGHUfC1Tb6E4pudI9STA"; }    
          { name = "Luke Smith"; url = "https://www.youtube.com/feeds/videos.xml?channel_id=UC2eYFnH61tmytImy1mTYvhA"; }    
          { name = "Distrotube"; url = "https://www.youtube.com/feeds/videos.xml?channel_id=UCVls1GmFKf6WlTraIb_IaJg"; }    
          { name = "Brodie Robertson"; url = "https://www.youtube.com/feeds/videos.xml?channel_id=UCld68syR8Wi-GY_n4CaoJGA"; }    
          { name = "Gavin Freeborn"; url = "https://www.youtube.com/feeds/videos.xml?channel_id=UCJetJ7nDNLlEzDLXv7KIo0w"; }    
          { name = "SystemCrafters"; url = "https://www.youtube.com/feeds/videos.xml?channel_id=UCAiiOTio8Yu69c3XnR7nQBQ"; }    
          { name = "Bread on Penguins"; url = "https://www.youtube.com/feeds/videos.xml?channel_id=UCwHwDuNd9lCdA7chyyquDXw"; }    
          { name = "By Default"; url = "https://www.youtube.com/feeds/videos.xml?channel_id=UC8wKWWarusivFpIcUx9ilOw"; }      

          # Gaming
          { name = "Grian"; url = "https://www.youtube.com/feeds/videos.xml?channel_id=UCR9Gcq0CMm6YgTzsDxAxjOQ"; }    
          { name = "Mumbo"; url = "https://www.youtube.com/feeds/videos.xml?channel_id=UChFur_NwVSbUozOcF_F2kMg"; }    
          { name = "FitMC"; url = "https://www.youtube.com/feeds/videos.xml?channel_id=UCHZ986wm_sJT6wntdDTIIcw"; }    
          { name = "SalC1"; url = "https://www.youtube.com/feeds/videos.xml?channel_id=UClY084mbGLK_SLlOfgizjow"; }    

          { name = "ChiefLogan"; url = "https://www.youtube.com/feeds/videos.xml?channel_id=UCogZrz65kvH51R6poGP9h7w"; }    
          { name = "Chippy Gaming"; url = "https://www.youtube.com/feeds/videos.xml?channel_id=UCdImtrRS4UewEbPdnF8R4qw"; }    
          { name = "Chippy's Couch"; url = "https://www.youtube.com/feeds/videos.xml?channel_id=UCkfTUab0xxTMPRTNgs9vMCQ"; }    
          { name = "Gungnir"; url = "https://www.youtube.com/feeds/videos.xml?channel_id=UCzYkMlFTQxQlRvVPLezP1kA"; }    
          { name = "Terrasteel"; url = "https://www.youtube.com/feeds/videos.xml?channel_id=UCGprDqZlt5epQ6-fFbU-nmQ"; }    
          { name = "Wand of Sparking"; url = "https://www.youtube.com/feeds/videos.xml?channel_id=UC83aVV53W2TzlpqGZYFqeZA"; }    
          { name = "Wild lmao"; url = "https://www.youtube.com/feeds/videos.xml?channel_id=UCkIHALu6PUYO-789D-wLuxg"; }    

          { name = "Skurry"; url = "https://www.youtube.com/feeds/videos.xml?channel_id=UCYX2-exnYmc6gDObfooTGZg"; }    
          { name = "Fireb0rn"; url = "https://www.youtube.com/feeds/videos.xml?channel_id=UCEYGHOLgKlLMDNrGCno3oJA"; }    
          { name = "mossbag"; url = "https://www.youtube.com/feeds/videos.xml?channel_id=UCTvH45HvnOzqXvfNJqdc3xg"; }    
          { name = "gamechamp3000"; url = "https://www.youtube.com/feeds/videos.xml?channel_id=UCDm-nYAJuqrBIy57EgWAymw"; }    

          { name = "Ceave Perspective"; url = "https://www.youtube.com/feeds/videos.xml?channel_id=UCepgG8BiC4jlGTSZfYkpHiQ"; }    
          { name = "Ceave Gaming"; url = "https://www.youtube.com/feeds/videos.xml?channel_id=UCFXc5nAao6554AIXlN9KgwQ"; }    

          { name = "Pekinwolf"; url = "https://www.youtube.com/feeds/videos.xml?channel_id=UCP9q8DRbsTDPhU4E0R3-1rA"; }    

          { name = "Minimme"; url = "https://www.youtube.com/feeds/videos.xml?channel_id=UCPIBtu2SBuW_VFHwKwDOtYg"; }      

          ## Speedrunning
          { name = "Abysoft"; url = "https://www.youtube.com/feeds/videos.xml?channel_id=UC6I9iYfcBQTCsiGpR3kV1Uw"; }    
          { name = "Bismuth"; url = "https://www.youtube.com/feeds/videos.xml?channel_id=UCQ9STd0zeHrrQGJQEuvhuTw"; }    
          { name = "EZScape"; url = "https://www.youtube.com/feeds/videos.xml?channel_id=UCIyZiiHXIH7KkqfaDvBmG-Q"; }    
          { name = "Karl Jobst"; url = "https://www.youtube.com/feeds/videos.xml?channel_id=UC3ltptWa0xfrDweghW94Acg"; }    
          { name = "Kosmic"; url = "https://www.youtube.com/feeds/videos.xml?channel_id=UC6esFMAIud24sYSHfHGzPhg"; }    
          { name = "storster"; url = "https://www.youtube.com/feeds/videos.xml?channel_id=UCwsPUhCVbx82sfHyZce8Nug"; }    
          { name = "tomatoanus"; url = "https://www.youtube.com/feeds/videos.xml?channel_id=UCm6GSA5OROHcIBNkXkH53zQ"; }    
          { name = "tasmalleo"; url = "https://www.youtube.com/feeds/videos.xml?channel_id=UC5C-7TI6goM9uQ7Gf3JwnRQ"; }    
          { name = "Any Percent"; url = "https://www.youtube.com/feeds/videos.xml?channel_id=UCyu8hwmz5EviXDl37_nQqdg"; }    
          { name = "Lowest Percent"; url = "https://www.youtube.com/feeds/videos.xml?channel_id=UCxQrToVDBwHKuyIr47X04yA"; }    
          { name = "LunaticJ"; url = "https://www.youtube.com/feeds/videos.xml?channel_id=UC6Tp0ptVPoykN-tnhy7gEIw"; }      

          # Go
          { name = "In Sente"; url = "https://www.youtube.com/feeds/videos.xml?channel_id=UCP14BOcc0Rg9-TXXv2I4AkA"; }    
          { name = "Telegraph Go"; url = "https://www.youtube.com/feeds/videos.xml?channel_id=UCJ8bZ_fK5G5o23pJ4DZAx8g"; }    
          { name = "Go Magic"; url = "https://www.youtube.com/feeds/videos.xml?channel_id=UCqerkZelwpOiq56XXPmfZSQ"; }    
          { name = "Strugglebus Go"; url = "https://www.youtube.com/feeds/videos.xml?channel_id=UCqrvttITQtlrQ9I7VNlsHBQ"; }    
          { name = "dwyrin"; url = "https://www.youtube.com/feeds/videos.xml?channel_id=UCCYMY6j5mUvPMPzvN5bxuKA"; }    
          { name = "haylee"; url = "https://www.youtube.com/feeds/videos.xml?channel_id=UCTji1kQNoWIH85dB_Vxka9g"; }    
          { name = "Nick Sibicky"; url = "https://www.youtube.com/feeds/videos.xml?channel_id=UC_msctwlIh2cwM8yAtaju1A"; }    
          { name = "Sunday Go Lessons"; url = "https://www.youtube.com/feeds/videos.xml?channel_id=UC1_FV_v1Ceq0DMk1kyWkwbw"; }    
          { name = "American Go Association"; url = "https://www.youtube.com/feeds/videos.xml?channel_id=UCR3qjXCiYEokW7bW3HkFzfg"; }    
          { name = "Go Commentary"; url = "https://www.youtube.com/feeds/videos.xml?channel_id=UCHpNHQQnuWA8mmdAzpvltAA"; }    
          { name = "Andrew Jackson"; url = "https://www.youtube.com/feeds/videos.xml?channel_id=UCGAASXnrt4FtYfFZ608PqHA"; }    
          { name = "Shawn Ray"; url = "https://www.youtube.com/feeds/videos.xml?channel_id=UCBxqdZfHo8MHyZ1iuRtAoXw"; }    
          { name = "Michael Redmond"; url = "https://www.youtube.com/feeds/videos.xml?channel_id=UCRJyagla1B5cxIfR4i2LdgA"; }      

          # Other
          { name = "All Things Lost"; url = "https://www.youtube.com/feeds/videos.xml?channel_id=UCGuuPSmUAmAuOvWFjfPHFCQ"; }    
          { name = "Barely Sociable"; url = "https://www.youtube.com/feeds/videos.xml?channel_id=UC9PIn6-XuRKZ5HmYeu46AIw"; }    
          { name = "Slightly Sociable"; url = "https://www.youtube.com/feeds/videos.xml?channel_id=UCgmI-uiLLAg--vDe7FFdekA"; }    
          { name = "Nexpo"; url = "https://www.youtube.com/feeds/videos.xml?channel_id=UCpFFItkfZz1qz5PpHpqzYBw"; }      
          { name = "How to Cook That"; url = "https://www.youtube.com/feeds/videos.xml?channel_id=UCsP7Bpw36J666Fct5M8u-ZA"; }      


          ## Science
          { name = "Cody's Lab"; url = "https://www.youtube.com/feeds/videos.xml?channel_id=UCu6mSoMNzHQiBIOCkHUa2Aw"; }    
          { name = "Nilered"; url = "https://www.youtube.com/feeds/videos.xml?channel_id=UCFhXFikryT4aFcLkLw2LBLA"; }    
          { name = "Angela Collier"; url = "https://www.youtube.com/feeds/videos.xml?channel_id=UCtscFf8VayggrDYjOwDke_Q"; }      


          ## Mathematics
          { name = "Computerphile"; url = "https://www.youtube.com/feeds/videos.xml?channel_id=UC9-y-6csu5WGm29I7JiwpnA"; }    
          { name = "Numberphile"; url = "https://www.youtube.com/feeds/videos.xml?channel_id=UCoxcjq-8xIDTYp3uz647V5A"; }      

          ## Urban Exploration
          { name = "The Proper People"; url = "https://www.youtube.com/feeds/videos.xml?channel_id=UCcem9I78ybZLHLRUlkUO3sw"; }    
          { name = "Shiey"; url = "https://www.youtube.com/feeds/videos.xml?channel_id=UCpXwMqnXfJzazKS5fJ8nrVw"; }      


          # Politics
          ## Leftist Video Essays
          { name = "Contrapoints"; url = "https://www.youtube.com/feeds/videos.xml?channel_id=UCNvsIonJdJ5E4EXMa65VYpA"; }    
          { name = "Hbomberguy"; url = "https://www.youtube.com/feeds/videos.xml?channel_id=UClt01z1wHHT7c5lKcU8pxRQ"; }    
          { name = "PhilosophyTube"; url = "https://www.youtube.com/feeds/videos.xml?channel_id=UC2PA-AKmVpU6NKCGtZq_rKQ"; }    
          { name = "Shaun"; url = "https://www.youtube.com/feeds/videos.xml?channel_id=UCJ6o36XL0CpYb6U5dNBiXHQ"; }    
          { name = "Lindsay Ellis"; url = "https://www.youtube.com/feeds/videos.xml?channel_id=UCG1h-Wqjtwz7uUANw6gazRw"; }    

          { name = "orowen"; url = "https://www.youtube.com/feeds/videos.xml?channel_id=UCPnCyGlGMd02FCgifbOLBYQ"; }    

          { name = "Thought Slime"; url = "https://www.youtube.com/feeds/videos.xml?channel_id=UCrr7y8rEXb7_RiVniwvzk9w"; }    
          { name = "Sophie from Mars"; url = "https://www.youtube.com/feeds/videos.xml?channel_id=UCJmlCcnfMlyPA2oSbb072QA"; }    

          { name = "Mexie"; url = "https://www.youtube.com/feeds/videos.xml?channel_id=UCepkun0sH16b-mqxBN22ogA"; }    
          { name = "Positive Leftist News"; url = "https://www.youtube.com/feeds/videos.xml?channel_id=UC2jXeGiElzyMmW8NJt2ajfg"; }    
          { name = "Xexizy"; url = "https://www.youtube.com/feeds/videos.xml?channel_id=UCDULjo1v2Hivuu4h4LZSTUQ"; }    
          { name = "Badmouse Productions"; url = "https://www.youtube.com/feeds/videos.xml?channel_id=UCFEmOPY04flXH-QpMMAGeJA"; }    

          { name = "1Dime"; url = "https://www.youtube.com/feeds/videos.xml?channel_id=UCQWoY8CkEGeE4t62djCZk-A"; }    
          { name = "Plastic Pills"; url = "https://www.youtube.com/feeds/videos.xml?channel_id=UC9XFvuObhfVUNAGNcH8Y_fw"; }    
          { name = "Epoch Philosophy"; url = "https://www.youtube.com/feeds/videos.xml?channel_id=UC738SsV6BSLUVvMgKnEFFzQ"; }    
          { name = "Tom Nicholas"; url = "https://www.youtube.com/feeds/videos.xml?channel_id=UCxt2r57cLastdmrReiQJkEg"; }    
          { name = "Tom Nicholas 2"; url = "https://www.youtube.com/feeds/videos.xml?channel_id=UCV4MuJHfEXNMjrjwcd4tHEA"; }    
          { name = "CCK Philosophy"; url = "https://www.youtube.com/feeds/videos.xml?channel_id=UCSkzHxIcfoEr69MWBdo0ppg"; }    

          { name = "Jose"; url = "https://www.youtube.com/feeds/videos.xml?channel_id=UCeDKIj0G5XbultKOQnacu_w"; }    
          { name = "Big Joel"; url = "https://www.youtube.com/feeds/videos.xml?channel_id=UCaN8DZdc8EHo5y1LsQWMiig"; }    
          { name = "Little Joel"; url = "https://www.youtube.com/feeds/videos.xml?channel_id=UCEeL4jELzooI7cyrouQzoJg"; }    
          { name = "Sarah Z"; url = "https://www.youtube.com/feeds/videos.xml?channel_id=UCK-GxvzttTnNhq3JPYpXhqg"; }    
          { name = "Jack Saint"; url = "https://www.youtube.com/feeds/videos.xml?channel_id=UCdQKvqmHKe_8fv4Rwe7ag9Q"; }    
          { name = "Super Eyepatch Wolf"; url = "https://www.youtube.com/feeds/videos.xml?channel_id=UCtGoikgbxP4F3rgI9PldI9g"; }    

          { name = "The Leftist Cooks"; url = "https://www.youtube.com/feeds/videos.xml?channel_id=UC358urzyldvD78E9o2sR-Og"; }    
          { name = "Zoe Bee"; url = "https://www.youtube.com/feeds/videos.xml?channel_id=UCecF2icZlEIJ__9XS6woPGw"; }    
          { name = "Mia Mulder"; url = "https://www.youtube.com/feeds/videos.xml?channel_id=UC_OttpBEWWzSUlZbk5qmhSA"; }    

          { name = "Rowan Ellis"; url = "https://www.youtube.com/feeds/videos.xml?channel_id=UCniXurp_3xcDh923eiqGX3w"; }    
          { name = "Some More News"; url = "https://www.youtube.com/feeds/videos.xml?channel_id=UCvlj0IzjSnNoduQF0l3VGng"; }    
          { name = "Rebecca Watson"; url = "https://www.youtube.com/feeds/videos.xml?channel_id=UCFJxE0l3cVYU4kHzi4qVEkw"; }    
          { name = "The Kavernacle"; url = "https://www.youtube.com/feeds/videos.xml?channel_id=UCoG5ya-sMXNMkqkIz1sZ_Lw"; }    

          { name = "oliSUNvia"; url = "https://www.youtube.com/feeds/videos.xml?channel_id=UCVHxJghKAB_kA_5LMM8MD3w"; }    
          { name = "Mina Le"; url = "https://www.youtube.com/feeds/videos.xml?channel_id=UCoOss5XiPpnLHGmLrBvNkJg"; }    

          { name = "Münecat"; url = "https://www.youtube.com/feeds/videos.xml?channel_id=UCqNpjt_UcMPgm_9gphZgHYA"; }    
          { name = "Timbah.On.Toast"; url = "https://www.youtube.com/feeds/videos.xml?channel_id=UC5G1ThclVYLp2YFQUodTNnA"; }    
          { name = "Unemployed Historian"; url = "https://www.youtube.com/feeds/videos.xml?channel_id=UCQqCMWFHSNGfGcqEFp9Cl0A"; }    
          { name = "Unlearning Economics"; url = "https://www.youtube.com/feeds/videos.xml?channel_id=UC4V_jMdRbbTrmBVJB6FDzgw"; }    
          { name = "We're in Hell"; url = "https://www.youtube.com/feeds/videos.xml?channel_id=UCbbsW7_Esx8QZ8PgJ13pGxw"; }    

          { name = "Wendover Productions"; url = "https://www.youtube.com/feeds/videos.xml?channel_id=UC9RM-iSvTu1uPJb8X5yp3EQ"; }    
          { name = "Wendigoon"; url = "https://www.youtube.com/feeds/videos.xml?channel_id=UC3cpN6gcJQqcCM6mxRUo_dA"; }    

          { name = "Sam Reid"; url = "https://www.youtube.com/feeds/videos.xml?channel_id=UCa3t89CuxPJFX2vvgagRUYw"; }    
          { name = "Drew Gooden"; url = "https://www.youtube.com/feeds/videos.xml?channel_id=UCTSRIY3GLFYIpkR2QwyeklA"; }    
          { name = "Eddy Burbank"; url = "https://www.youtube.com/feeds/videos.xml?channel_id=UCuo9VyowIT-ljA5G2ZuC6Yw"; }    
          { name = "Ted Nivison"; url = "https://www.youtube.com/feeds/videos.xml?channel_id=UCJGgP4txIUr_7JTDvOGVQrA"; }    

          { name = "Fredda"; url = "https://www.youtube.com/feeds/videos.xml?channel_id=UCrbPsI5RvQybygZykPUxBSA"; }    

          { name = "CJ the X"; url = "https://www.youtube.com/feeds/videos.xml?channel_id=UC6LEH0rS9V0BF5aNhVYdykQ"; }    
          { name = "Low Level"; url = "https://www.youtube.com/feeds/videos.xml?channel_id=UC6biysICWOJ-C3P4Tyeggzg"; }    

          ##News
          { name = "Majority Report"; url = "https://www.youtube.com/feeds/videos.xml?channel_id=UC-3jIAlnQmbbVMV6gR7K8aQ"; }    
          { name = "Badempanada"; url = "https://www.youtube.com/feeds/videos.xml?channel_id=UCUzmizB92LJ9oxf5T_snZNA"; }    
        ];
      };
    };
  };
}

