// Page 15
case class Flight(DEST_COUNTRY_NAME: String, ORIGIN_COUNTRY_NAME: String, count: BigInt)
val flightsDF = spark.read.parquet("./part-r-00000.gz.parquet")
val flights = flightsDF.as[Flight]

// Page 16
flights.show(2)
flights.first
flights.first.DEST_COUNTRY_NAME

def originIsDestination(flight_row: Flight): Boolean ={
  return flight_row.ORIGIN_COUNTRY_NAME == flight_row.DEST_COUNTRY_NAME
}

flights.filter(flight_row => originIsDestination(flight_row)).first()
flights.collect().filter(flight_row => originIsDestination(flight_row))

// Page 17
val destinations = flights.map(f => f.DEST_COUNTRY_NAME)
val localDestinations = destinations.take(5)

// Page 18
case class FlightMetadata(count: BigInt, randomData: BigInt)
val flightsMeta = spark.range(500).map(x => (x, scala.util.Random.nextLong)).withColumnRenamed("_1", "count").withColumnRenamed("_2", "randomData").as[FlightMetadata]
val flights2 = flights.joinWith(flightsMeta, flights.col("count") === flightsMeta.col("count"))
flights2.take(2)
val flights2 = flights.join(flightsMeta, Seq("count"))
flights2.take(2)

// Page 19
flights.groupBy("DEST_COUNTRY_NAME").count()
flights.groupByKey(x => x.DEST_COUNTRY_NAME).count()

// Page 20
def sum2 (left:Flight, right:Flight) = {
  Flight(left.DEST_COUNTRY_NAME, null, left.count + right.count)
}
flights.groupByKey(x => x.DEST_COUNTRY_NAME).reduceGroups((l,r) => sum2(l,r)).take(5)

// Page 21
flights.groupBy("DEST_COUNTRY_NAME").count().explain
flights.groupByKey(x => x.DEST_COUNTRY_NAME).count().explain
