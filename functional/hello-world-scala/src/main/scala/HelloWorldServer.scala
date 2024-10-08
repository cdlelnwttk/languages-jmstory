import akka.actor.typed.ActorSystem
import akka.actor.typed.scaladsl.Behaviors
import akka.http.scaladsl.Http
import akka.http.scaladsl.server.Directives._
import scala.io.Source
import scala.io.StdIn
import io.circe.parser._
import scala.util.Using


object HelloWorldServer {
    implicit val system = ActorSystem(Behaviors.empty, "helloWorldSystem")
    implicit val executionContext = system.executionContext

     def main(args: Array[String]): Unit = {
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

    val fileName = getClass.getResourceAsStream("/list.json")
    //reading in file
    val stringList = Using(fileName) { stream =>
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
      path("sortedStringList") {
        get {
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
