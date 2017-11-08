module Data.RaceType exposing (RaceType, RaceType(..), raceType, raceTypeToString, raceTypeDecoder)

import Json.Decode
import Json.Decode.Extra

type RaceType
    = Classic
    | Criterium
    | Regiocross
    | Other
    | Unknown

raceType : String -> RaceType
raceType string =
    case string of
        "classic" ->
            Classic

        "criterium" ->
            Criterium

        "regiocross" ->
            Regiocross

        "other" ->
            Other

        _ ->
            Other


raceTypeToString : RaceType -> String
raceTypeToString category =
    case category of
        Classic ->
            "classic"

        Criterium ->
            "criterium"

        Regiocross ->
            "regiocross"

        Other ->
            "other"

        Unknown ->
            "unknown"

raceTypeDecoder : String -> Json.Decode.Decoder RaceType
raceTypeDecoder string =
    Json.Decode.succeed (raceType string)
