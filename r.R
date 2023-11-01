flightsData <- readRDS("data/flightsData_week8.rds")
dplyr::glimpse(flightsData)
# 1. which ScheduleStartDate need plus 1
## Find out which DepartureTime has +1 at the end
whichNeedPlus1 <- grep(pattern = "+1", flightsData$DepartureTime, fixed = TRUE)

whichNeedPlus1
## Add one day to those ScheduleStartDate

### teach R understand date so it can do plus one day later
flightsData
ScheduleStartDate)


departureDate <- flightsData$ScheduleStartDate
departureDate[whichNeedPlus1] <- departureDate[whichNeedPlus1] + lubridate::days(1)


# 2. paste date time together
departureTimeString <- flightsData$DepartureTime
# remove "+1" at the end
departureTimeString <- flightsData$DepartureTime
departureTimeString <- sub("+1", "", departureTimeString, fixed = T)

departureTime <- paste(departureDate, departureTimeString)

head(departureTime)
flightsData$DepartureTime <- departureTime # replace the old DepartureTime inside the data frame
# 3. parse time with time zone
## split flightsData according to its timezone
flightsData |> split(flightsData$DepartureTimeZone) -> split_flightsData
dplyr::glimpse(split_flightsData[[1]])
# for each sub data frame
.x=1 # say the first one
# we want to parse the time
split_flightsData[[.x]]
DepartureTime,
tz = split_flightsData[[.x]]$DepartureTimeZone[[1]])
names(split_flightsData[[.x]])
flightsData |> split(flightsData$DepartureTimeZone) -> split_flightsData
.x = 1
dplyr::mutate(
  split_flightsData[[.x]],
  DepartureTime = lubridate::ymd_hm(DepartureTime, tz = DepartureTimeZone[[1]])
)
flightsData |> split(flightsData$DepartureTimeZone) -> split_flightsData

.x = 1
# Or better in pipe expression
split_flightsData[[.x]] |>
  dplyr::mutate(
    DepartureTime = lubridate::ymd_hm(DepartureTime, tz = DepartureTimeZone[[1]])
  )

