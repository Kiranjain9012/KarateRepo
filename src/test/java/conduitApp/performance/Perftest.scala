package performance;

import com.intuit.karate.gatling.PreDef._
import io.gatling.core.Predef._
import scala.concurrent.duration._

class Perftest extends Simulation {

  val protocol = karateProtocol(
      "/api/articles/{slug}" -> Nil
  )

protocol.nameResolver = (req, ctx) => req.getHeader("karate-name")

  val csvFeeder = csv("articles.csv").circular // use a comma separator

  val createArticle = scenario("Create and Delete Article").feed(csvFeeder).exec(karateFeature("classpath:conduitApp/performance/createArticle.feature"))

  setUp(
    createArticle.inject(
         atOnceUsers(1),
         nothingFor(4 seconds),
         constantUsersPerSec(1) during (3 seconds),
        //  constantUsersPerSec(2) during (10 seconds), 
        //  rampUsersPerSec(2) to 10 during (20 seconds), 
        //  nothingFor(4 seconds),
        //  constantUsersPerSec(1) during (5 seconds),
        // rampUsersPerSec(10) to 20 during (10 minutes) randomized,
        // heavisideUsers(1000) during (20 seconds)
    ).protocols(protocol)
  )

}