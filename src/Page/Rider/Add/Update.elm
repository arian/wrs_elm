module Page.Rider.Add.Update exposing (update)

import App.Model exposing (App)
import App.Page
import Json.Encode
import App.OutsideInfo exposing (sendInfoOutside)
import Page.Rider.Add.Msg as Msg exposing (Msg)
import Data.Licence exposing (licenceToString)


update : Msg -> App -> ( App, Cmd Msg )
update msg app =
    case app.page of
        App.Page.RiderAdd page ->
            case msg of
                Msg.Submit ->
                    let
                        payload =
                            Json.Encode.object
                                [ ( "name", Json.Encode.string page.name )
                                , ( "licence", Json.Encode.string <| licenceToString page.licence )
                                ]
                    in
                        ( app, sendInfoOutside <| App.OutsideInfo.RiderAdd payload )

                Msg.Name name ->
                    let
                        nextPage =
                            App.Page.RiderAdd
                                { page | name = name }
                    in
                        ( { app | page = nextPage }, Cmd.none )

                Msg.Licence licence ->
                    let
                        nextPage =
                            App.Page.RiderAdd
                                { page | licence = Just licence }
                    in
                        ( { app | page = nextPage }, Cmd.none )

        _ ->
            ( app, Cmd.none )