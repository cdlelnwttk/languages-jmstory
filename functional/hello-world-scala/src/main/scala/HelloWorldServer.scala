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

    def insertionSort[T](list: List[T])(implicit ord: Ordering[T]): List[T] = {
  list match {
    case Nil => Nil // Base case: an empty list is already sorted
    case head :: tail =>
      insert(head, insertionSort(tail)) // Insert the head into the sorted tail
  }
}

def insert[T](element: T, sortedList: List[T])(implicit ord: Ordering[T]): List[T] = {
  sortedList match {
    case Nil => List(element) // If the sorted list is empty, just add the element
    case head :: tail =>
      if (ord.lt(element, head)) element :: sortedList // Insert before the head if smaller
      else head :: insert(element, tail) // Recursively insert into the tail
  }
}


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
          complete(s"List 1:\n${stringList.sorted.mkString(", ")}\n\nList 2:\n${stringList.sortWith((a, b) => a.toLowerCase < b.toLowerCase)}\n\n${insertionSort(stringList)}")
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
