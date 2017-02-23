module Rider.Model exposing (Rider, Licence, Licence(..))


type Licence
    = Elite
    | Amateurs
    | Basislidmaatschap
    | Other


type alias Rider =
    { id : Int
    , name : String
    , licence : Maybe Licence
    }
