library(ggplot2)

report <- read.csv(file = 'data/data.csv')
area <- read.csv(file = 'data/daftararea.csv', sep = ';', quote = '"')

head(area)
head(report)

report$id <- factor(report$id) 
area$Area <- area$area_name # comply column name for area name on both dataframes to be merge on that (I want to get the Lat and Lon)

total <- merge(area,report,by="Area")

total <- na.omit(total)

#remove unnecessary columns
total <- total[, !names(total) %in% c("parent_id", "area_name", "X", "TrackingID", "KategoriID", "DisposisiInstansiID", "AreaID", "TanggalDisposisi", "TanggalLaporanMasuk", "TanggalLaporanAktivitasTerakhir", "TanggalLaporanDitutup", "TimestampTanggalDisposisi", "created_at", "updated_at")]

#rename column's names
#https://stackoverflow.com/questions/6081439/changing-column-names-of-a-data-frame

colnames(total) <- c("area", 
                     "latitude", 
                     "longitude", 
                     "id", 
                     "reporter",
                     "category", 
                     "related_department", 
                     "status",
                     "report_issued",
                     "report_last_activity",
                     "report_closed")

# remove rare factor levels
# https://stackoverflow.com/questions/24259194/elegant-way-to-drop-rare-factor-levels-from-data-frame

write.csv(total, file = 'data/total.csv')
