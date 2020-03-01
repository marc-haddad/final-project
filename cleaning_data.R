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

# Keeps columns that have LESS THAN 500 'NA' values
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
pattern_hon = ".*^[HO]+[MND]+.*"
pattern_for = ".*^FORD.*"

checker(pattern_toy) # Checks for anything similar to 'TOYOTA'
checker(pattern_hon) # Checks for anything similar to 'HONDA'
checker(pattern_for) # Checks for anything similar to 'FORD'


# Here is where the data actually gets cleaned
clean_data = filtered_data %>% 
  mutate(vehicle_make = str_replace(vehicle_make,
                                    # "toyota" in place of anything that matches pattern
                                    pattern_toy, "toyota"),
         vehicle_make = str_replace(vehicle_make,
                                    # "honda" in place of anything that matches pattern
                                    pattern_hon, "honda"),
         vehicle_make = str_replace(vehicle_make,
                                    # "ford" in place of anything that matches pattern
                                    pattern_for, "ford"))


# Sum of makes before cleaning:
v_count(renamed_data)

# Sum of makes after cleaning:
v_count(clean_data)


