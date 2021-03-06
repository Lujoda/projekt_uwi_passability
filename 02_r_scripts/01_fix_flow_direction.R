# ------------------------------ #
### --- Fix flow direction --- ### 
# ------------------------------ #

# date written: 21.10.20
# date changed: 28.10.20 

# Used to be part of 005_create_map.R. Exacted because it is also useful for other parts of the project. 

# overview # 

## OPTIONS 
workshop=FALSE
remove=FALSE
save=TRUE
# setup -------------------------------------------------------------------
pacman::p_load(data.table,
               dplyr,
               here,
               magrittr,
               sf,
               stringr,
               tmap)
# dirs
dir_da  = here("01_data/")
dir_fun = here("02_r_scripts/")

# load reverse function 
source(file.path(dir_fun, "f_01_reverse.R"))
source(file.path(dir_fun, "f_02_add_river.R"))

# load data ---------------------------------------------------------------
dt_rivers = readRDS(file.path(dir_da, "rivers.RDS"))
st_sites  = readRDS(file.path(dir_da, "sites_original.RDS"))

# carpeting ---------------------------------------------------------------
dt_rivers[, ecoserv_number := as.numeric(str_extract(string=ecoserv_id, pattern="[0-9].*"))]

dt_rivers[ecoserv_id == "rlp_6", FROM := "dlaaa"]

# delete segments ---------------------------------------------------------
dt_rivers  <-
        dt_rivers[!ecoserv_id %in% c(
                "rlp_55",
                "rlp_56",
                "rlp_203",
                "rlp_212",
                "rlp_214",
                "rlp_374",
                "rlp_248",
                "rlp_740",
                "rlp_10137",
                "rlp_10152",
                "rlp_10174",
                "rlp_10420",
                "rlp_10595",
                "rlp_10596",
                "rlp_10597",
                "rlp_10598",
                "rlp_10599",
                "rlp_10604",
                "rlp_10605",
                "rlp_10606",
                "rlp_10610",
                "rlp_10648",
                "rlp_10649",
                "rlp_10650",
                "rlp_10651",
                "rlp_10652",
                "rlp_10653",
                "rlp_10654",
                "rlp_10736",
                "rlp_10982",
                "rlp_10983",
                "rlp_10988",
                "rlp_10990",
                "rlp_10991",
                "rlp_10992",
                "rlp_10993",
                "rlp_16929",
                "rlp_16930",
                
                "swd_19631",
                "swd_32406",
                "swd_33118",
                "swd_34009",
                "swd_37142",
                "swd_37658",
                "swd_37712",
                "swd_38065",
                "swd_39272",
                "swd_40883",
                "swd_41717",
                "swd_43986",
                "swd_48147",
                "swd_67705",
                "swd_63726",
                "swd_64279",
                "swd_64280",
                "swd_67704",
                "swd_69582",
                "swd_71702",
                "swd_71703",
                "swd_71961",
                
                "vdn_6661",
                "vdn_7861"
       
)]


# manual improvements -----------------------------------------------------
dt_rivers[ecoserv_id == "rlp_54"   , FROM := "P52"]
dt_rivers[ecoserv_id == "rlp_192"  , FROM := "P2184"]
dt_rivers[ecoserv_id == "rlp_192"  , TO := "p_add_01"]
dt_rivers[ecoserv_id == "rlp_10118", FROM := "P2590"]
dt_rivers[ecoserv_id == "rlp_10143", FROM := "P2634"]
dt_rivers[ecoserv_id == "rlp_10143", TO   := "P2638"]
dt_rivers[ecoserv_id == "rlp_10280", FROM := "P3136"]
dt_rivers[ecoserv_id == "rlp_10389", TO := "Px3136"]
dt_rivers[ecoserv_id == "rlp_10390", FROM := "Px3136"]
dt_rivers[ecoserv_id == "rlp_10390", TO := "P3136"]
dt_rivers[ecoserv_id == "rlp_10391", FROM := "P3136"]
dt_rivers[ecoserv_id == "rlp_10394", FROM := "P2917"]
dt_rivers[ecoserv_id == "rlp_10398", FROM := "P3150"]
dt_rivers[ecoserv_id == "rlp_10398", TO   := "P3160"]
dt_rivers[ecoserv_id == "rlp_10399", FROM := "P3150"]
dt_rivers[ecoserv_id == "rlp_10509", FROM := "P3374"]
dt_rivers[ecoserv_id == "rlp_10560", FROM := "P3474"]
dt_rivers[ecoserv_id == "rlp_10580", FROM := "P3474"]
dt_rivers[ecoserv_id == "rlp_10581", FROM := "P3480"]
dt_rivers[ecoserv_id == "rlp_10589", FROM := "P3512"]
dt_rivers[ecoserv_id == "rlp_10611", FROM := "P3414"]
dt_rivers[ecoserv_id == "rlp_10627", FROM := "P3598"]
dt_rivers[ecoserv_id == "rlp_10627", TO   := "P3612"]
dt_rivers[ecoserv_id == "rlp_10634", FROM := "P3422"]
dt_rivers[ecoserv_id == "rlp_11198", TO   := "P404"]
dt_rivers[ecoserv_id == "rlp_14111", FROM := "P29614"]
dt_rivers[ecoserv_id == "rlp_14942", TO   := "P11990"]
dt_rivers[ecoserv_id == "rlp_16937", FROM   := "P2917"]

dt_rivers[ecoserv_id == "vdn_2342" , TO   := "P28346"]
dt_rivers[ecoserv_id == "vdn_2342" , FROM := "P22684"]
dt_rivers[ecoserv_id == "vdn_4399" , FROM := "P22684"]
dt_rivers[ecoserv_id == "vdn_7362" , FROM := "P20200"]
dt_rivers[ecoserv_id == "vdn_7362" , TO   := "P22508"]

dt_rivers[ecoserv_id == "sar_4600",  FROM := "P10674"]
dt_rivers[ecoserv_id == "sar_8158",  FROM := "P117261"]
dt_rivers[ecoserv_id == "sar_8158",  TO   := "P114079"]
dt_rivers[ecoserv_id == "sar_8400",  FROM := "P122813"]
dt_rivers[ecoserv_id == "sar_8400",  TO   := "P403"]
dt_rivers[ecoserv_id == "vdn_16960", FROM := "P10564"]



# out ---------------------------------------------------------------------
# Not sure anymore what this does ... 
dt_rivers[ecoserv_id %in% c("vdn_6657", "vdn_6658", "vdn_6660"), c("FROM", "TO") := c(1,2,3)]

# reverse -----------------------------------------------------------------
dt_rivers = reverse(x= c(
        "rlp_197", 
        "rlp_537",
        
        "rlp_10080",
        "rlp_10081",
        "rlp_10107",
        "rlp_10108",
        "rlp_10109",
        "rlp_10116",
        "rlp_10117",
        "rlp_10138",
        "rlp_10139",
        "rlp_10141",
        "rlp_10145",
        "rlp_10146",
        "rlp_10279",
        "rlp_10283",
        "rlp_10284",
        "rlp_10285",
        "rlp_10333", 
        "rlp_10334",
        "rlp_10338",
        #"rlp_10339",
        "rlp_10400",
        "rlp_10406", 
        "rlp_10407",
        "rlp_10418",
        "rlp_10470",
        "rlp_10478",
        "rlp_10506",
        "rlp_10557",
        "rlp_10558",
        "rlp_10559",
        "rlp_10562",
        "rlp_10584",
        "rlp_10585",
        "rlp_10592",
        "rlp_10593",
        "rlp_10632",
        "rlp_10639",
        "rlp_10640",
        "rlp_10642",
        "rlp_10645",
        "rlp_10674",
        "rlp_10726",
        "rlp_10727",
        "rlp_10770",
        "rlp_11002",
        "rlp_11005",
        "rlp_11007",
        "rlp_11011",
        "rlp_11015",
        "rlp_11019",
        "rlp_11021",
        "rlp_11132",
        "rlp_11140",
        "rlp_11158",
        "rlp_11159",
        "rlp_11160",
        "rlp_11178",
        "rlp_11200",
        "rlp_11220",
        "rlp_11221",
        "rlp_11273",
        "rlp_11298",
        "rlp_11309",
        "rlp_11315",
        "rlp_11331",
        "rlp_11401",
        "rlp_11448",
        
        "rlp_11718",
        "rlp_11758",
        "rlp_12282",
        "rlp_12283",
        "rlp_12737",
        "rlp_12748",
        "rlp_12784",
        "rlp_12788",
        "rlp_12800",
        "rlp_12822",
        "rlp_12836",
        "rlp_12862",
        "rlp_12872",
        "rlp_12874",
        "rlp_12875",
        "rlp_12876",
        "rlp_12908",
        "rlp_12917",
        "rlp_13889",
        "rlp_13910",
        "rlp_13913",
        "rlp_13917",
        "rlp_13928",
        "rlp_13962",
        "rlp_13975",
        "rlp_13978",
        "rlp_14038",
        "rlp_14046",
        "rlp_14101",
        "rlp_14147",
        "rlp_14157",
        "rlp_14696",
        "rlp_14697",
        "rlp_14719",
        "rlp_14924",
        "rlp_14933",
        "rlp_14935",
        "rlp_15187",
        "rlp_15191",
        "rlp_15434",
        "rlp_15703",
        "rlp_15804",
        "rlp_15808",
        "rlp_15831",
        "rlp_15905",
        "rlp_16348",
        "rlp_16613",
        "rlp_16614",
        "rlp_16615",
        "rlp_16623",
        "rlp_16626",

        "vdn_247",
        "vdn_2088",
        "vdn_3804",
        "vdn_3872",
        "vdn_4394",
        "vdn_4400",
        "vdn_4416",
        "vdn_4634",
        "vdn_5421",
        "vdn_5890",
        "vdn_6121",
        "vdn_7371",
        "vdn_7393",
        "vdn_7398",
        "vdn_7408",
        "vdn_7412",
        "vdn_7413",
        "vdn_7426",
        "vdn_7436",
        "vdn_7468",
        "vdn_7469",
        "vdn_7470",
        "vdn_7683",
        #"vdn_7685",
        "vdn_7687",
        #"vdn_7689",
        "vdn_7698",
        "vdn_7700",
        "vdn_7963",
        "vdn_7964",
        "vdn_7965",
        "vdn_7966",
        "vdn_7967",
        "vdn_8047",
        "vdn_8103",
        # "vdn_8104",
        
        "swd_40692",
        "swd_45701",
        "swd_45704",
        "swd_51994",
        "swd_53519",
        "swd_53521",
        "swd_53543",
        "swd_53544",
        "swd_53545",
        "swd_53546",
        "swd_53547",
        "swd_53548",
        "swd_53549",
        "swd_53550",
        "swd_53551",
        "swd_53552",
        "swd_53553",
        "swd_59472",
        "swd_63164",
        "swd_63165",
        "swd_63166",
        "swd_65204",
        "swd_68114",
        "swd_68110",
        "swd_68105",
        "swd_68104",
        "swd_68107",
        "swd_68109",
        "swd_68143",
        "swd_68145",
        "swd_68146",
        "swd_68147",
        "swd_68155",
        "swd_68157", 
        "swd_68181",
        
        
        "sar_444",
        "sar_464",
        "sar_477",
        "sar_3319",
        "sar_6538",
        "sar_6547",
        "sar_7140",
        "sar_7290",
        "sar_7287",
        "sar_7291",
        "sar_7309",
        "sar_7318",
        "sar_8158",
        "sar_8159",
        "sar_8160",
        "sar_8161",
        "sar_8163",
        "sar_8165",
        "sar_8167",
        "sar_8170",
        "sar_8171"
))

# add new lines  ----------------------------------------------------------
dt_rivers = add_river(from_line = "rlp_148", to_line = "rlp_10105",
                      from_point = "P42", to_point = "P44"
                      )
dt_rivers = add_river(from_line = "rlp_54", to_line = "swd_68189",
                      from_point = "P26", to_point = "P104120"
                      )
dt_rivers = add_river(from_line = "rlp_188", to_line = "rlp_9913",
                      from_point = "P52", to_point = "P2183"
                      )
dt_rivers = add_river(from_line = "rlp_10145", to_line = "rlp_201",
                      from_point = "P2648", to_point = "P61"
                      )
dt_rivers = add_river(from_line = "rlp_201", to_line = "rlp_202",
                      from_point = "P62", to_point = "P54"
                      )
dt_rivers = add_river(from_line = "rlp_202", to_line = "swd_68185",
                      from_point = "P64", to_point = "P104112"
                      )
dt_rivers = add_river(from_line = "rlp_192", to_line = "rlp_191",
                      from_point = "p_add_01", to_point = "P55"
                      )
dt_rivers = add_river(from_line = "rlp_10403", to_line = "swd_68158",
                      from_point = "P3160", to_point = "P104058"
                      )
dt_rivers = add_river(from_line = "rlp_373", to_line = "swd_68162",
                      from_point = "P128", to_point = "P104066"
                      )
dt_rivers = add_river(from_line = "rlp_10594", to_line = "swd_68142",
                      from_point = "P3546", to_point = "P103151"
                      )
dt_rivers = add_river(from_line = "rlp_727", to_line = "rlp_728",
                      from_point = "P226", to_point = "P228"
                      )
dt_rivers = add_river(from_line = "rlp_11219", to_line = "rlp_11220",
                      from_point = "P4796", to_point = "P4782"
                      )
dt_rivers = add_river(from_line = "rlp_3128", to_line = "rlp_12726",
                      from_point = "P746", to_point = "P4678"
                      )
dt_rivers = add_river(from_line = "rlp_14384", to_line = "rlp_14385",
                      from_point = "P11126", to_point = "P10962"
                      )
dt_rivers = add_river(from_line = "rlp_6696", to_line = "rlp_15803",
                      from_point = "P1724", to_point = "P8940"
                      )
dt_rivers = add_river(from_line = "rlp_782", to_line = "swd_68123",
                      from_point = "P244", to_point = "P103988"
                      )
dt_rivers = add_river(from_line = "swd_68100", to_line = "rlp_10994",
                      from_point = "P244", to_point = "P4344"
                      )


# modify added lines  -----------------------------------------------------
dt_rivers[ecoserv_id == "add_72929", FROM := "P103941"]

## ---- add rows ----- ## 
new_number_rlp <- dt_rivers[str_detect(string=ecoserv_id,pattern="rlp"), max(ecoserv_number)]
dt_new_row <- data.table(ecoserv_id = paste0("rlp_", new_number_rlp + 1:2), 
                         FROM       = c("P42","P52"   ),
                         TO         = c("P44", "P2183"), 
                         score_up   = 1,
                         score_down = 1,
                         ecoserv_number = new_number_rlp + 1:2, 
                         geom       = c(dt_rivers[TO == "P42", geom], 
                                        dt_rivers[TO == "P52", geom])
)

dt_rivers <- rbindlist(list(dt_rivers, dt_new_row), 
                       use.names = TRUE)

## second delete step 
dt_rivers = dt_rivers[!ecoserv_id %in% c(
        "rlp_10404",
        "rlp_16932",
        "rlp_16934",
        "rlp_16961",
        "rlp_16962",
        # temp 
        "rlp_10138"
)
]

rm(add_river, dir_fun, dt_new_row, new_number_rlp, reverse);gc()


# save to file  -----------------------------------------------------------
if (save) {
saveRDS(object=dt_rivers,
        file=file.path(dir_da, "fixed_rivers.RDS"))
}
if (remove) {
        rm(list=ls());gc()
}
# workshop ---------------------------------------------------------------
if (workshop){
        
        tmap_mode("view")
        st_rivers = st_as_sf(dt_rivers)
        st_sites%<>%st_transform(crs=st_crs(st_rivers))
        
        # ## -- what? -- ## 
        sub=tb_edge_id_sub$ecoserv_id
        
        sub=c("PW_01", "PW02")
        
        rivers_sub=dt_rivers[ecoserv_id %in% sub]
        
        rivers_sub %>%
                mutate(fromto=paste(FROM, TO)) %>%
                st_as_sf() %>%
                tm_shape() + tm_lines(col="ecoserv_id", lwd=3) +
                tm_text(text="fromto")
        # 
        # ## -- bbox around sites -- ## 
        # ## -- + plot            -- ## 
        st_sites_sub = filter(st_sites, site %in% c("PW_01", "PW_02"))
        
        st_sites_sub %>%
                st_bbox() * c(.99,.99,1.11,1.11) ->
                cut_bbox
        # 
        st_cropped=sf::st_crop(
                x=st_rivers,
                y=cut_bbox
                )
        # 
        tm_shape(st_cropped) + tm_lines() +
                tm_shape(st_sites_sub) + tm_dots(col = "red")
        # 
        # ## ------------------- ## 
        # ## -- add lines eda -- ## 
        
        # extract lines between which a link is missing 
        st_rivers_sub =
                st_rivers %>%
                filter(ecoserv_id %in% c("rlp_188", "rlp_9913"))
         
        st_data = st_rivers
        st_data_sub = st_data %>%
                filter(ecoserv_id %in% c(from_line, to_line))
        
        st_data_sub_points =
                st_data_sub %>%
                st_cast(to = "POINT") %>%
                mutate(p_id = row_number())
        
        st_line_to = st_data_sub %>%
                filter(ecoserv_id == to_line)
        st_line_from = st_data_sub %>%
                filter(ecoserv_id == from_line)
        st_points_from = st_data_sub_points %>%
                filter(ecoserv_id == from_line)
        st_points_to = st_data_sub_points %>%
                filter(ecoserv_id == to_line)
        st_points_from = st_points_from[c(1, nrow(st_points_from)), ]
        st_points_to = st_points_to[c(1, nrow(st_points_to)), ]
        
        tm_shape(st_points_from) + tm_dots() +
                tm_shape(st_points_to) + tm_dots()
         
        p_id1 = st_nearest_feature(x = st_line_to,
                                   y = st_points_from)
        p_id2 = st_nearest_feature(x = st_line_from,
                                   y = st_points_to)
        p_id1 = st_points_from$p_id[p_id1]
        p_id2 = st_points_to$p_id[p_id2]
        
        # cast to points
        options(warn=-1);
        st_rivers_sub_point =
                st_rivers_sub %>%
                st_cast(to = "POINT");
        options(warn=1)
         
        st_rivers_sub_point %<>%
                mutate(p_id = 1:nrow(st_rivers_sub_point))
        point_id_2 <-
                unique(st_nearest_feature(
                        filter(st_rivers_sub_point, ecoserv_id == "rlp_188"),
                        filter(st_rivers_sub_point, ecoserv_id == "rlp_9913")
                ))
        point_id_1 <-
                unique(st_nearest_feature(
                        filter(st_rivers_sub_point, ecoserv_id == "rlp_9913"),
                        filter(st_rivers_sub_point, ecoserv_id == "rlp_188")
                ))
        point_id_1 = filter(st_rivers_sub_point, ecoserv_id == "rlp_9913") %>%
                st_drop_geometry() %>%
                select(p_id) %>%
                .[point_id_1,]
        
        point_id_2 = filter(st_rivers_sub_point, ecoserv_id == "rlp_188") %>%
                st_drop_geometry() %>%
                select(p_id) %>%
                .[point_id_2,]
         
        tm_shape(st_rivers_sub_point) +
                tm_dots()
        
        st_rivers_sub_point %>%
                filter(p_id %in% c(442, 446)) %>%
                st_coordinates(st_new_line) %>%
                .[, -3] %>%
                list() %>%
                st_multilinestring() %>%
                st_sfc() ->
                st_new_line
        
        st_crs(st_new_line)=st_crs(st_rivers_sub)
        
        tm_shape(st_rivers_sub) + tm_lines() +
                tm_shape(st_new_line) + tm_lines()
         
        df_attributes = data.frame(
                "ecoserv_id" = paste0("add_",
                                      max(dt_rivers$ecoserv_number) + 1),
                "FROM" = "P40",
                "TO"   = "P44",
                score_up=1,
                score_down=1,
                ecoserv_number=max(dt_rivers$ecoserv_number) + 1
        )
        
        st_new_line = st_sf(df_attributes, geom = st_new_line)
        st_crs(st_new_line)=st_crs(st_rivers)
        st_rivers %<>% rbind(st_new_line)
        
        
        #-----------------------#
        
        
        
        ## ------------------- ##
        
        
        to_split <- rivers[ecoserv_id == "vdn_7861"]
        to_split %<>% st_as_sf()
        to_split %<>% st_cast("POINT")
        
        st_nearest_feature(y = to_split,
                           x = st_as_sf(rivers[ecoserv_id == "rlp_16958"]))
}
