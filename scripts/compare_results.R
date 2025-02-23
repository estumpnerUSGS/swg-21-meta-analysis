# load data
DC <- read.csv("data_raw/DC_assignments_results.csv")
MB <- read.csv("data_raw/MB_assignments_split_reviewed.csv")
PG <- read.csv("data_raw/PG_assignments_results.csv")
LY <- read.csv("data_raw/LY_assignments_results.csv")

CP <- read.csv("data_raw/Abstracts_cp.csv")
ES <- read.csv("data_raw/ES_assignments_results.csv")
RP <- read.csv("data_raw/RP_assignments_split.csv")
#DC <- data.frame(DC)
#MB <- data.frame(MB)

# rename columns
colnames(DC)[17] <- "result_DC"
colnames(MB)[17] <- "result_MB"
colnames(PG)[17] <- "result_PG"
colnames(LY)[8] <- "result_LY"
colnames(LY)[2] <- "title"

colnames(CP)[8] <- "result_CP"
colnames(CP)[2] <- "title"
colnames(ES)[17] <- "result_ES"
colnames(RP)[17] <- "result_RP"

# change to unsure (also called 'maybe' and '?')
DC$result_DC <- ifelse(DC$result_DC == "?", "unsure", DC$result_DC)
PG$result_PG <- ifelse(PG$result_PG == "maybe", "unsure", PG$result_PG)

CP$result_CP <- ifelse(CP$result_CP == "U", "unsure", CP$result_CP)
ES$result_ES <- ifelse(ES$result_ES == "M", "unsure", ES$result_ES)

# make lower case
LY$result_LY <- tolower(LY$result_LY)

CP$result_CP <- tolower(CP$result_CP)
ES$result_ES <- tolower(ES$result_ES)
RP$result_RP <- tolower(RP$result_RP)

# merge by title
#compare_DC_MB <- merge(DC[,c(2,17)], MB[,c(2,17)], by = "title")
#compare_DC_PG <- merge(DC[,c(2,17)], PG[,c(2,17)],  by = "title")
#compare_DC_LY <- merge(DC[,c(2,17)], LY[,c(2,8)],  by = "title")
#compare_DC_CP <- merge(DC[,c(2,17)], CP[,c(2,8)], by = "title")
#compare_DC_ES <- merge(DC[,c(2,17)], ES[,c(2,17)], by = "title")
#compare_DC_RP <- merge(DC[,c(2,17)], RP[,c(2,17)], by = "title")

#compare_MB_PG <- merge(MB[,c(2,17)], PG[,c(2,17)],  by = "title")
#compare_MB_LY <- merge(MB[,c(2,17)], LY[,c(2,8)],  by = "title")
#compare_MB_CP <- merge(MB[,c(2,17)], CP[,c(2,8)],  by = "title")
#compare_MB_ES <- merge(MB[,c(2,17)], ES[,c(2,17)],  by = "title")
#compare_MB_RP <- merge(MB[,c(2,17)], RP[,c(2,17)],  by = "title")

#compare_PG_LY <- merge(PG[,c(2,17)], LY[,c(2,8)],  by = "title")
#compare_PG_CP <- merge(PG[,c(2,17)], CP[,c(2,8)],  by = "title")
#compare_PG_ES <- merge(PG[,c(2,17)], ES[,c(2,17)],  by = "title")
#compare_PG_RP <- merge(PG[,c(2,17)], RP[,c(2,17)],  by = "title")

#compare_LY_CP <- merge(LY[,c(2,8)], CP[,c(2,8)],  by = "title")
#compare_LY_ES <- merge(LY[,c(2,8)], ES[,c(2,17)],  by = "title")
#compare_LY_RP <- merge(LY[,c(2,8)], RP[,c(2,17)],  by = "title")

#compare_CP_ES <- merge(CP[,c(2,8)], ES[,c(2,17)],  by = "title")
#compare_CP_RP <- merge(CP[,c(2,8)], RP[,c(2,17)],  by = "title")

#compare_ES_RP <- merge(ES[,c(2,17)], RP[,c(2,17)], by = "title")

# true/false (agreement/disagreement)

#compare$agree_disagree <- ifelse(!is.na(compare) & compare$result_DC == compare$result_MB == compare$result_PG == compare$result_LY, 1, 0)

#compare$agree_disagree <- identical(compare$result_DC, compare$result_MB, compare$result_PG)

#compare$agree_disagree <-!mapply(`%in%`, compare$result_DC, compare$result_MB, compare$result_PG)

#`%!=na%` <- function(e1, e2) (e1 != e2 | (is.na(e1) & !is.na(e2)) | (is.na(e2) & !is.na(e1))) & !(is.na(e1) & is.na(e2))

#compare$agree_disagree <- duplicated(compare[,c(2:5)], incomparables = "NA")
#compare$agree_disagree <- duplicated(compare[c("result_DC", "result_MB", "result_PG", "result_LY")], na.rm = TRUE)
#compare$agree_disagree <- unique(compare[,c(2:5)], incomparables = "NA")
#compare$agree_disagree <- compare[!duplicated(compare$result_DC, compare$result_MB, compare$result_PG), ]


# master list with unique IDs
all_titles <- read.csv("data_clean/assignments_all.csv")
all_titles <- all_titles[,c(1,3,5,6)]
all_titles$ID <- seq.int(nrow(all_titles))

compare_abstracts <- merge(merge(merge(merge(merge(merge(merge(all_titles, DC[,c(2,17)], by='title', all=T), MB[,c(2,17)], by='title', all=TRUE), PG[,c(2,17)],  by = "title", all=TRUE), LY[,c(2,8)],  by = "title", all=TRUE), CP[,c(2,8)], by = "title", all=TRUE), ES[,c(2,17)], by = "title", all=TRUE), RP[,c(2,17)], by = "title", all=TRUE)

# 4 of LY titles are showing up as different (typos intriduced between export and abstract review), fixed in github - DONE

# need to update with DC and LY edits after 12/17 meeting - DONE

# missed a duplicated title bc of "</sub>" - DONE
compare_abstracts <- compare_abstracts[-17,]
compare_abstracts[16, 11] <- "n"

# change CP's unsure to NO and Liz's unsure to YES (decided at 12/17 meeting)
compare_abstracts[70, 11] <- "y"
compare_abstracts[71, 10] <- "n"

# Dylan has two entries for the same title, looking at notes, 'y' is the final
compare_abstracts <- compare_abstracts[-39,]

# also need to redo IDs - DONE
compare_abstracts[,5] <- seq.int(nrow(compare_abstracts))

write.csv(compare_abstracts, "data_clean/abstract_results_chl.csv")

#compare_abstracts$NO <- apply(compare_abstracts, 1, function(r) any(r == "n"))


