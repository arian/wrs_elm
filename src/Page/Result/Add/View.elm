module Page.Result.Add.View exposing (view)

import Html exposing (Html, span, button, div, text, label, h2, input, i, p, option, select)
import Html.Attributes exposing (autofocus, class, id, type_, for, disabled, name, checked, value)
import Html.Events exposing (onInput, onClick)
import Data.Outfit as Outfit exposing (Outfit)
import Data.Race exposing (Race)
import Data.Rider exposing (Rider)
import Data.ResultCategory as ResultCategory exposing (ResultCategory)
import Data.RaceResult exposing (RaceResult)
import Page.Result.Add.Model exposing (Model)
import Page.Result.Add.Msg as Msg exposing (Msg)


view : Race -> Model -> List Rider -> List RaceResult -> Html Msg
view race resultAdd riders results =
    let
        submitDisabled =
            --not (riderNameExists resultAdd.riderName riders)
            -- ||
            String.isEmpty resultAdd.result ||
            resultAdd.riderKey == Nothing

        filteredRiders =
            List.filter
                (\rider -> not <| resultExists rider race results)
                riders

        items =
            List.map
                (\rider ->
                    { text = rider.name
                    , value = rider.key
                    }
                )
                filteredRiders
    in
        div []
            [ h2 [ class "title is-2" ] [ text ("Add result for " ++ race.name) ]
            , div [ class "field is-horizontal" ]
                [ div [ class "field-label" ]
                    [ label [ class "label", for "result" ] [ text "Result" ]
                    ]
                , div [ class "field-body" ]
                    [ div [ class "field" ]
                        [ p [ class "control has-icons-left" ]
                            [ input
                                [ id "result"
                                , class "input"
                                , type_ "text"
                                , onInput Msg.Result
                                , autofocus True
                                ]
                                []
                            , span [ class "icon is-small is-left" ] [ i [ class "fa fa-trophy" ] [] ]
                            ]
                        ]
                    ]
                ]
            , div [ class "field is-horizontal" ]
                [ div [ class "field-label" ]
                    [ label [ class "label", for "result" ] [ text "Rider" ]
                    ]
                , div [ class "field-body" ]
                    [ div [ class "field" ]
                        [ div [ class "control" ]
                            [ div [ class "select" ]
                                [ select [ onInput Msg.Rider ]
                                    ( [ option [] [] ] ++ List.map (\item -> option [ value item.value ] [ text item.text  ] ) items )
                                ]
                            ]
                        ]
                    ]
                ]
            , div [ class "field is-horizontal" ]
                [ div [ class "field-label" ]
                    [ label [ class "label", for "result" ] [ text "Category" ]
                    ]
                , div [ class "field-body" ]
                    [ div [ class "field" ]
                        [ p [ class "control" ] [ resultCategoryButtons ]
                        ]
                    ]
                ]
            , div [ class "field is-horizontal" ]
                [ div [ class "field-label" ]
                    [ label [ class "label", for "result" ] [ text "Outfit" ]
                    ]
                , div [ class "field-body" ]
                    [ div [ class "field" ]
                        [ p [ class "control" ] [ outfitButtons ]
                        ]
                    ]
                ]
            , div [ class "field is-horizontal" ]
                [ div [ class "field-label" ] []
                , div [ class "field-body" ]
                    [ div [ class "field" ]
                        [ p [ class "control" ]
                            [ button
                                [ class "button is-primary"
                                , type_ "submit"
                                , onClick Msg.Submit
                                , Html.Attributes.name "action"
                                , disabled submitDisabled
                                ]
                                [ text "Add result" ]
                            ]
                        ]
                    ]
                ]
            ]


resultExists : Rider -> Race -> List RaceResult -> Bool
resultExists rider race results =
    List.length
        (List.filter
            (\result -> race.key == result.raceKey && rider.key == result.riderKey)
            results
        )
        == 1


resultCategoryButtonCheck : String -> String -> ResultCategory -> Bool -> Html Msg
resultCategoryButtonCheck resultCategoryName resultCategoryText category isChecked =
    p []
        [ input [ checked isChecked, name "resultCategory", type_ "radio", id resultCategoryName, onClick (Msg.Category category) ] []
        , label [ for resultCategoryName ] [ text resultCategoryText ]
        ]


resultCategoryButton : String -> String -> ResultCategory -> Html Msg
resultCategoryButton resultCategoryName resultCategoryText resultCategory =
    resultCategoryButtonCheck resultCategoryName resultCategoryText resultCategory False


resultCategoryButtons : Html Msg
resultCategoryButtons =
    div []
        [ resultCategoryButtonCheck "amateurs" "Amateurs" ResultCategory.Amateurs True
        , resultCategoryButton "basislidmaatschap" "Basislidmaatschap" ResultCategory.Basislidmaatschap
        , resultCategoryButton "cata" "Cat A" ResultCategory.CatA
        , resultCategoryButton "catb" "Cat B" ResultCategory.CatB
        ]


outfitButton : String -> String -> Outfit -> Bool -> Html Msg
outfitButton outfitName outfitLabel outfit isChecked =
    p []
        [ input [ checked isChecked, name "outfit", type_ "radio", id outfitName, onClick (Msg.Outfit outfit) ] []
        , label [ for outfitName ] [ text outfitLabel ]
        ]


outfitButtons : Html Msg
outfitButtons =
    div []
        [ outfitButton "wtos" "WTOS" Outfit.WTOS True
        , outfitButton "wasp" "WASP" Outfit.WASP False
        , outfitButton "other" "Other" Outfit.Other False
        ]