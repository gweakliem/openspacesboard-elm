-- openspaces board Elm mockup

module OpenspacesBoard where

import Date exposing (Date)
import Html exposing (..)
import Html.Attributes exposing (..)
import String
import Time exposing (Time)
import Result exposing (Result)
import List
import StartApp.Simple exposing (start)

-- MODEL
type alias LocationModel = {
    name: String
  }


type alias SessionModel =
    { name : String,
      description: String,
      convener: String,
      startTime: String,
      endTime: String,
      location: LocationModel
    }


type alias Model =
    {
      sessions : List ( SessionModel )
    }


makeLocation name =
  { name = name }


makeSession name description convener startTime endTime location =
  { name = name, description = description, convener = convener,
    startTime = startTime,
    endTime = endTime,
    location = location}


initialModel : Model
initialModel = {
  sessions = [
      (makeSession "Is Scala Dead?" "Talking about Scala" "Bruce" "2016-02-29 09:45" "2016-02-29 10:45"
        (makeLocation "Stained Glass")),
      (makeSession "Talking about ponies" "" "Carl" "2016-02-29 09:45" "2016-02-29 10:45"
        (makeLocation "Rumors"))
    ]
  }


-- UPDATE

type Action = NoOp
  | SortByTime
--  | SortByLocation
--  | AddSession

update action model =
  case action of
    NoOp ->
      model

    SortByTime ->
      { model | sessions = List.sortBy .startTime model.sessions }

--    SortByLocation ->
--      { model | sessions = List.sortBy .location model.sessions }

-- VIEW

makeSessionItem : SessionModel -> Html
makeSessionItem session =
  li [class "session-item"]
    [div [class "session-tile"]
      [text session.name,
       div [class "badge"] [text session.convener]
      ]
    ]


sessionList : List(SessionModel) -> Html
sessionList sessions =
  ul [class "session-list"]
    (List.map makeSessionItem sessions)


pageHeader : Html
pageHeader =
  div [class "header"] []


pageFooter: Html
pageFooter =
  div [class "footer"] []


view : Signal.Address Action -> Model -> Html
view address model =
  div [id "container"]
    [ pageHeader,
      sessionList model.sessions,
      pageFooter
      ]


main =
  StartApp.Simple.start { model = initialModel, update = update, view = view }
