library(tidyverse)
library(stringr)
library(readr)

crash_data <- read_csv("crash_data.csv", 
                       col_types = cols(
                         Circumstance = col_skip(), 
                         `Local Case Number` = col_character(), 
                         `Off-Road Description` = col_skip()
                         )
                       )



# Rename Columns
renamed_data = crash_data %>% 
  rename(report_id = `Report Number`, 
         local_case_id = `Local Case Number`,
         agency_name = `Agency Name`,
         report_type = `ACRS Report Type`,
         crash_date_time = `Crash Date/Time`,
         route_type = `Route Type`,
         road_name = `Road Name`,
         cross_street_type = `Cross-Street Type`,
         cross_street_name = `Cross-Street Name`,
         collision_type = `Collision Type`,
         weather = Weather,
         surface_condition = `Surface Condition`,
         light = Light,
         traffic_control = `Traffic Control`,
         driver_substance_abuse = `Driver Substance Abuse`,
         person_id = `Person ID`,
         driver_at_fault = `Driver At Fault`,
         injury_severity = `Injury Severity`,
         driver_distracted_by = `Driver Distracted By`,
         driver_license_state = `Drivers License State`,
         vehicle_id = `Vehicle ID`,
         vehicle_dmg_extent = `Vehicle Damage Extent`,
         vehicle_first_impact_loc = `Vehicle First Impact Location`,
         vehicle_second_impact_loc = `Vehicle Second Impact Location`,
         vehicle_body_type = `Vehicle Body Type`,
         vehicle_movement = `Vehicle Movement`,
         vehicle_continuing_dir = `Vehicle Continuing Dir`,
         vehicle_going_dir = `Vehicle Going Dir`,
         speed_limit = `Speed Limit`,
         driverless_vehicle = `Driverless Vehicle`,
         parked_vehicle = `Parked Vehicle`,
         vehicle_year = `Vehicle Year`,
         vehicle_make = `Vehicle Make`,
         vehicle_model = `Vehicle Model`,
         equipment_problems = `Equipment Problems`,
         latitude = Latitude,
         longitude = Longitude,
         location = Location
         )

# Keeps columns that have LESS THAN 500 'NA' values, then, drop rows with 'NA'
renamed_data = renamed_data[, colSums(is.na(renamed_data)) < 500] %>% drop_na()

# Applies filter that keeps vehicle makes that are metioned at least 3 times.
filtered_data = renamed_data %>% group_by(vehicle_make) %>% mutate(count=n()) %>% 
  filter(count > 3) %>% 
  ungroup()

# Function that returns the strings to be replaced (for testing patterns)
checker = function(pattern){
  filtered_data %>% 
    filter(str_detect(filtered_data$vehicle_make, pattern)) %>% 
    group_by(vehicle_make) %>% 
    summarize(count = n()) %>% 
    View()
}

# Function that returns unique vehicle makes and provides their respective counts (for testing the effects of patterns)
v_count = function(df){
  df %>% 
    group_by(vehicle_make) %>% 
    summarize(count=n()) %>%
    arrange(desc(count)) %>% 
    View()
}


# Patterns to be searched within strings (this is called regex, don't worry about it)
pattern_toy = ".*^[TYO][POYT0][YTO0].*"
pattern_hon = ".*^[HO]+I?[MND]+(?!O).*"
pattern_for = ".*^FORD.*"
pattern_nis = ".*^NIS.*"
pattern_dod = ".*^DODG.*|.*^RAM.*"
pattern_chv = ".*^CHEV.*"
pattern_hyu = ".*^H[YUN]+(?!M).*"
pattern_lex = ".*^LEX.*"
pattern_unx = ".*^UNK.*|.*^X+.*|.*^[09]+.*"
pattern_acu = ".*^AC.*"
pattern_maz = ".*^MA[ZD].*"
pattern_sub = ".*^SUB.*"
pattern_gmc = ".*^GM.*|.*^GEN.*"
pattern_tom = ".*^TH[OM]+.*"
pattern_mer = ".*^MER[CZ](?!U).*|.*BENZ.*"
pattern_gil = ".*^GIL.*"
pattern_cry = ".*^C[RH]+Y(?!E)S?(?!V)(?!A).*"
pattern_vov = ".*^VOLV.*"
pattern_vow = ".*^V[OLKSW\\s]+(?!V).*"
pattern_new = ".*^N[E?W]+.*|.*^FLY.*|.*^NFLY.*"
pattern_bui = ".*^BUIC.*"
pattern_inf = ".*^INF.*"
pattern_cad = ".*^CAD.*"
pattern_mit = ".*^MIT.*"
pattern_frt = ".*^FREI.*|.*^FRT.*|.*^FTL.*|.*FRHT.*"
pattern_sat = ".*^SAT[UR]+.*|.*^STRN.*"
pattern_sci = ".*^SCIO.*"
pattern_lin = ".*^LINC.*"
pattern_mac = ".*^MAC.*"
pattern_int = ".*^INT.*"
pattern_min = ".*^MINI.*|.*^MNN.*"
pattern_suz = ".*^SUZ.*"
pattern_pon = ".*^PON.*"
pattern_ori = ".*^ORI.*"
pattern_isu = ".*^ISU.*"
pattern_jag = ".*^JAG.*"
pattern_spa = ".*^SPA.*"
pattern_har = ".*^HARL.*"
pattern_lnd = ".*^LAND.*|.*^LNDR.*|.*^RANG.*|.*^ROV.*"
pattern_por = ".*^POR.*"
pattern_str = ".*^ST[ERAN]+.*|.*^STLG.*"
pattern_saa = ".*^SAA.*"
pattern_tsl = ".*^TESL.*"

checker(pattern_toy) # Checks for anything similar to provided pattern

# Here is where the data actually gets cleaned
clean_data = filtered_data %>% 
  mutate(
    # "toyota" in place of anything that matches pattern
    vehicle_make = str_replace(vehicle_make, pattern_toy, "toyota"),
    
    # "honda" in place of anything that matches pattern
    vehicle_make = str_replace(vehicle_make, pattern_hon, "honda"),
    
    # "ford" in place of anything that matches pattern
    vehicle_make = str_replace(vehicle_make, pattern_for, "ford"),
    
    # "nissan" in place of anything that matches pattern
    vehicle_make = str_replace(vehicle_make, pattern_nis, "nissan"),
    
    # "dodge" in place of anything that matches pattern
    vehicle_make = str_replace(vehicle_make, pattern_dod, "dodge"),
    
    # "chevrolet" in place of anything that matches pattern
    vehicle_make = str_replace(vehicle_make, pattern_chv, "chevrolet"),
    
    # "hyundai" in place of anything that matches pattern
    vehicle_make = str_replace(vehicle_make, pattern_hyu, "hyundai"),
    
    # "lexus" in place of anything that matches pattern
    vehicle_make = str_replace(vehicle_make, pattern_lex, "lexus"),
    
    # "unknown" in place of anything that matches pattern
    vehicle_make = str_replace(vehicle_make, pattern_unx, "unknown"),
    
    # "acura" in place of anything that matches pattern
    vehicle_make = str_replace(vehicle_make, pattern_acu, "acura"),
    
    # "mazda" in place of anything that matches pattern
    vehicle_make = str_replace(vehicle_make, pattern_maz, "mazda"),
    
    # "subaru" in place of anything that matches pattern
    vehicle_make = str_replace(vehicle_make, pattern_sub, "subaru"),
    
    # "gmc" in place of anything that matches pattern
    vehicle_make = str_replace(vehicle_make, pattern_gmc, "gmc"),
    
    # "thomas" in place of anything that matches pattern
    vehicle_make = str_replace(vehicle_make, pattern_tom, "thomas"),
    
    # "mercedes" in place of anything that matches pattern
    vehicle_make = str_replace(vehicle_make, pattern_mer, "mercedes"),
    
    # "gillig_bus" in place of anything that matches pattern
    vehicle_make = str_replace(vehicle_make, pattern_gil, "gillig_bus"),
    
    # "chrysler" in place of anything that matches pattern
    vehicle_make = str_replace(vehicle_make, pattern_cry, "chrysler"),
    
    # "volvo" in place of anything that matches pattern
    vehicle_make = str_replace(vehicle_make, pattern_vov, "volvo"),
    
    # "vw" in place of anything that matches pattern
    vehicle_make = str_replace(vehicle_make, pattern_vow, "vw"),
    
    # "newflyer" in place of anything that matches pattern
    vehicle_make = str_replace(vehicle_make, pattern_new, "newflyer"),
    
    # "buick" in place of anything that matches pattern
    vehicle_make = str_replace(vehicle_make, pattern_bui, "buick"),
    
    # "infiniti" in place of anything that matches pattern
    vehicle_make = str_replace(vehicle_make, pattern_inf, "infiniti"),
    
    # "cadillac" in place of anything that matches pattern
    vehicle_make = str_replace(vehicle_make, pattern_cad, "cadillac"),
    
    # "mitsubishi" in place of anything that matches pattern
    vehicle_make = str_replace(vehicle_make, pattern_mit, "mitsubishi"),
    
    # "freightliner" in place of anything that matches pattern
    vehicle_make = str_replace(vehicle_make, pattern_frt, "freightliner"),
    
    # "saturn" in place of anything that matches pattern
    vehicle_make = str_replace(vehicle_make, pattern_sat, "saturn"),
    
    # "scion" in place of anything that matches pattern
    vehicle_make = str_replace(vehicle_make, pattern_sci, "scion"),
    
    # "lincoln" in place of anything that matches pattern
    vehicle_make = str_replace(vehicle_make, pattern_lin, "lincoln"),
    
    # "mack" in place of anything that matches pattern
    vehicle_make = str_replace(vehicle_make, pattern_mac, "mack"),
    
    # "international" in place of anything that matches pattern
    vehicle_make = str_replace(vehicle_make, pattern_int, "international"),
    
    # "minicooper" in place of anything that matches pattern
    vehicle_make = str_replace(vehicle_make, pattern_min, "minicooper"),
    
    # "suzuki" in place of anything that matches pattern
    vehicle_make = str_replace(vehicle_make, pattern_suz, "suzuki"),
    
    # "pontiac" in place of anything that matches pattern
    vehicle_make = str_replace(vehicle_make, pattern_pon, "pontiac"),
    
    # "orion" in place of anything that matches pattern
    vehicle_make = str_replace(vehicle_make, pattern_ori, "orion"),
    
    # "isuzu" in place of anything that matches pattern
    vehicle_make = str_replace(vehicle_make, pattern_isu, "isuzu"),
    
    # "jaguar" in place of anything that matches pattern
    vehicle_make = str_replace(vehicle_make, pattern_jag, "jaguar"),
    
    # "spartan" in place of anything that matches pattern 
    vehicle_make = str_replace(vehicle_make, pattern_spa, "spartan"),
    
    # "harley_davidson" in place of anything that matches pattern
    vehicle_make = str_replace(vehicle_make, pattern_har, "harley_davidson"),
    
    # "land_rover" in place of anything that matches pattern
    vehicle_make = str_replace(vehicle_make, pattern_lnd, "land_rover"),
    
    # "porsche" in place of anything that matches pattern
    vehicle_make = str_replace(vehicle_make, pattern_por, "porsche"),
    
    # "sterling" in place of anything that matches pattern
    vehicle_make = str_replace(vehicle_make, pattern_str, "sterling"),
    
    # "saab" in place of anything that matches pattern
    vehicle_make = str_replace(vehicle_make, pattern_saa, "saab"),
    
    # "tesla" in place of anything that matches pattern
    vehicle_make = str_replace(vehicle_make, pattern_tsl, "tesla"),
    
    # "kia" in place of anything that matches pattern
    vehicle_make = str_replace(vehicle_make, "^KIA$", "kia"),
    
    # "audi" in place of anything that matches pattern
    vehicle_make = str_replace(vehicle_make, "^AUDI$", "audi"),
    
    # "fiat" in place of anything that matches pattern
    vehicle_make = str_replace(vehicle_make, "^FIAT$", "fiat"),
    
    # "jeep" in place of anything that matches pattern
    vehicle_make = str_replace(vehicle_make, "^JEEP$", "jeep"),
    
    # "bmw" in place of anything that matches pattern
    vehicle_make = str_replace(vehicle_make, "^BMW$", "bmw"),
    
    # "mercury" in place of anything that matches pattern
    vehicle_make = str_replace(vehicle_make, "^MERCURY$", "mercury"),
    
    # "pierce" in place of anything that matches pattern
    vehicle_make = str_replace(vehicle_make, "^PIERCE", "pierce"),
    
    # Replaces the rest of obscure makes into "other"
    vehicle_make = str_replace(vehicle_make, "^[[:upper:]\\s?/?]+$", "other")
  )


# Sum of makes before cleaning:
v_count(renamed_data)

# Sum of makes after cleaning:
v_count(clean_data)

# Final check of data:
View(clean_data)

# Create new csv:
write_csv(clean_data, "clean_crash_data.csv")




