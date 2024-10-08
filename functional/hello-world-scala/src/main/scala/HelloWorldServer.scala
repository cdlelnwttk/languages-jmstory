import akka.actor.typed.ActorSystem
import akka.actor.typed.scaladsl.Behaviors
import akka.http.scaladsl.Http
import akka.http.scaladsl.server.Directives._
import scala.io.Source
import scala.io.StdIn
import io.circe.parser._
import scala.util.Using

object HelloWorldServer {
  def main(args: Array[String]): Unit = {
    // Create an ActorSystem
    implicit val system = ActorSystem(Behaviors.empty, "helloWorldSystem")
    implicit val executionContext = system.executionContext


    // Specify the JSON file path in the resources folder
    val jsonFilePath = getClass.getResourceAsStream("/list.json")

    // Read the JSON file into a List[String]
    val stringList = Using(jsonFilePath) { stream =>
      val jsonString = Source.fromInputStream(stream).getLines().mkString("\n")

      // Parse the JSON string into a List[String]
      parse(jsonString) match {
        case Right(json) =>
          json.as[List[String]] match {
            case Right(list) =>
              list
            case Left(error) =>
              println(s"Error parsing JSON: $error")
              List.empty[String]
          }
        case Left(error) =>
          println(s"Error parsing JSON: $error")
          List.empty[String]
      }
    }.getOrElse(List.empty[String]) // Provide a default value in case of an error


    // Define the route
    val route =
      path("greet" / Segment) { person =>
        get {
          complete(s"Hello, $person!")
        }
      } ~
      path("listOfStrings") {
        get {
          complete(s"List 1:\n${stringList.sorted.mkString(", ")}\n\nList 2:\n${stringList.sortWith((a, b) => a.toLowerCase < b.toLowerCase)}")
        }
      }

    // Start the server
    val bindingFuture = Http().newServerAt("localhost", 8080).bind(route)

    println("Server online at http://localhost:8080/\nPress RETURN to stop...")
    StdIn.readLine() // Keep the server running until user presses return
    bindingFuture
      .flatMap(_.unbind()) // Unbind from the port
      .onComplete(_ => system.terminate()) // Terminate the system when done
  }
}
