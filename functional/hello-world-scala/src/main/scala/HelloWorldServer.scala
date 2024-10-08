import akka.actor.typed.ActorSystem
import akka.actor.typed.scaladsl.Behaviors
import akka.http.scaladsl.Http
import akka.http.scaladsl.server.Directives._
import scala.io.Source
import scala.io.StdIn
import io.circe.parser._
import scala.util.Using

object HelloWorldServer {
  implicit val system: ActorSystem[Nothing] = ActorSystem(Behaviors.empty, "helloWorldSystem")
  implicit val executionContext = system.executionContext

  def main(args: Array[String]): Unit = {
    // Function to read the JSON file and return its contents as a String
    def readFile(filePath: String): Option[String] = {
      Using(getClass.getResourceAsStream(filePath)) { stream =>
        Source.fromInputStream(stream).getLines().mkString("\n")
      }.toOption // Convert to Option for easier error handling
    }

    // Function to parse the JSON file directly by reading and parsing it
    def parseJson(filePath: String): List[String] = {
      readFile(filePath) match {
        case Some(jsonString) =>
          parse(jsonString) match {
            case Right(json) => json.as[List[String]].getOrElse(List.empty[String])
            case Left(error) =>
              println(s"Error parsing JSON: $error")
              List.empty[String]
          }
        case None =>
          println("Error reading the JSON file.")
          List.empty[String]
      }
    }

    // Define the insertion sort
    def insertionSort(list: List[String]): List[String] = {
      list match {
        case Nil => Nil
        case head :: tail =>
          insert(head, insertionSort(tail))
      }
    }

    def insert(element: String, sortedList: List[String]): List[String] = {
      sortedList match {
        case Nil => List(element)
        case head :: tail =>
          if (element < head) element :: sortedList
          else head :: insert(element, tail)
      }
    }

    // Define the route after the sorting functions
    val route =
      path("greet" / Segment) { person =>
        get {
          complete(s"Hello, $person!")
        }
      } ~
      path("sortedStringList") {
        get {
           val stringList: List[String] = parseJson("/list.json")
          complete(
            s"""Unsorted List:
               |${stringList.mkString(", ")}
               |
               |List Sorted By Built-In Sort:
               |${stringList.sorted.mkString(", ")}
               |
               |List Sorted by Sort With:
               |${stringList.sortWith((a, b) => a.toLowerCase < b.toLowerCase).mkString(", ")}
               |
               |List Sorted By Insertion Sort:
               |${insertionSort(stringList).mkString(", ")}""".stripMargin
          )
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


