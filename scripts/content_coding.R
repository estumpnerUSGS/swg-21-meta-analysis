library(ggplot2)
library(dplyr)
library(tidyr)

head(full_text_review)
cc_results <- full_text_review[,c(1:5)]
# NAs not dilpalying correctly
cc_results[cc_results == "na"]=NA
cc_results <- na.omit(cc_results)

# responses were not consistant
unique(cc_results$connectivity_type)
cc_results$connectivity_type <- ifelse(cc_results$connectivity_type == "lateral", "2",
                                       ifelse(cc_results$connectivity_type == "lateral, longitudinal", "1, 2",
                                      ifelse(cc_results$connectivity_type == "longitudinal, hyporheic", "1, 3",
                                             ifelse(cc_results$connectivity_type == "1,3", "1, 3",
                                                    ifelse(cc_results$connectivity_type == "1, 2,3", "1, 2, 3", cc_results$connectivity_type)))))

cc_results$connectivity_type <- gsub("[?]", "", cc_results$connectivity_type)

cc_results$connectivity_measure <- tolower
# get rid of numbers for now
cc_results$connectivity_measure <- gsub('[0-9]+', '', cc_results$connectivity_measure)
cc_results$connectivity_measure <- gsub("[?]", "", cc_results$connectivity_measure)

(cc_results$connectivity_measure)
cc_results$seasonal_code <- tolower(cc_results$seasonal_code)
cc_results$repeats_code <- tolower(cc_results$repeats_code)

cc_results$seasonal_code <- ifelse(cc_results$seasonal_code == "yes", "y",
                                   ifelse(cc_results$seasonal_code == "no", "n",
                                          cc_results$seasonal_code))

cc_results$repeats_code <- ifelse(cc_results$repeats_code == "yes", "y",
                                   ifelse(cc_results$repeats_code == "no", "n",
                                          cc_results$repeats_code))
# notes included in same cell as results
cc_results[34, 5] <- "y"
cc_results[38, 5] <- "y"
cc_results[39, 5] <- "y"
cc_results[40, 5] <- "n"
cc_results[43, 5] <- "y"

write.csv(cc_results, "data_clean/connectivity_coding.csv")
