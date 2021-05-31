{-# LANGUAGE BangPatterns, DeriveDataTypeable, DeriveGeneric, FlexibleInstances, MultiParamTypeClasses #-}
{-# OPTIONS_GHC  -fno-warn-unused-imports #-}
module Crypto.Proto.Lol.RqProduct (RqProduct(..)) where
import Prelude ((+), (/))
import qualified Prelude as Prelude'
import qualified Data.Typeable as Prelude'
import qualified GHC.Generics as Prelude'
import qualified Data.Data as Prelude'
import qualified Text.ProtocolBuffers.Header as P'
import qualified Crypto.Proto.Lol.Rq as Crypto.Proto.Lol (Rq)

data RqProduct = RqProduct{rqs :: !(P'.Seq Crypto.Proto.Lol.Rq)}
                 deriving (Prelude'.Show, Prelude'.Eq, Prelude'.Ord, Prelude'.Typeable, Prelude'.Data, Prelude'.Generic)

instance P'.Mergeable RqProduct where
  mergeAppend (RqProduct x'1) (RqProduct y'1) = RqProduct (P'.mergeAppend x'1 y'1)

instance P'.Default RqProduct where
  defaultValue = RqProduct P'.defaultValue

instance P'.Wire RqProduct where
  wireSize ft' self'@(RqProduct x'1)
   = case ft' of
       10 -> calc'Size
       11 -> P'.prependMessageSize calc'Size
       _ -> P'.wireSizeErr ft' self'
    where
        calc'Size = (P'.wireSizeRep 1 11 x'1)
  wirePut ft' self'@(RqProduct x'1)
   = case ft' of
       10 -> put'Fields
       11 -> do
               P'.putSize (P'.wireSize 10 self')
               put'Fields
       _ -> P'.wirePutErr ft' self'
    where
        put'Fields
         = do
             P'.wirePutRep 10 11 x'1
  wireGet ft'
   = case ft' of
       10 -> P'.getBareMessageWith update'Self
       11 -> P'.getMessageWith update'Self
       _ -> P'.wireGetErr ft'
    where
        update'Self wire'Tag old'Self
         = case wire'Tag of
             10 -> Prelude'.fmap (\ !new'Field -> old'Self{rqs = P'.append (rqs old'Self) new'Field}) (P'.wireGet 11)
             _ -> let (field'Number, wire'Type) = P'.splitWireTag wire'Tag in P'.unknown field'Number wire'Type old'Self

instance P'.MessageAPI msg' (msg' -> RqProduct) RqProduct where
  getVal m' f' = f' m'

instance P'.GPB RqProduct

instance P'.ReflectDescriptor RqProduct where
  getMessageInfo _ = P'.GetMessageInfo (P'.fromDistinctAscList []) (P'.fromDistinctAscList [10])
  reflectDescriptorInfo _
   = Prelude'.read
      "DescriptorInfo {descName = ProtoName {protobufName = FIName \".crypto.proto.lol.RqProduct\", haskellPrefix = [], parentModule = [MName \"Crypto\",MName \"Proto\",MName \"Lol\"], baseName = MName \"RqProduct\"}, descFilePath = [\"Crypto\",\"Proto\",\"Lol\",\"RqProduct.hs\"], isGroup = False, fields = fromList [FieldInfo {fieldName = ProtoFName {protobufName' = FIName \".crypto.proto.lol.RqProduct.rqs\", haskellPrefix' = [], parentModule' = [MName \"Crypto\",MName \"Proto\",MName \"Lol\",MName \"RqProduct\"], baseName' = FName \"rqs\", baseNamePrefix' = \"\"}, fieldNumber = FieldId {getFieldId = 1}, wireTag = WireTag {getWireTag = 10}, packedTag = Nothing, wireTagLength = 1, isPacked = False, isRequired = False, canRepeat = True, mightPack = False, typeCode = FieldType {getFieldType = 11}, typeName = Just (ProtoName {protobufName = FIName \".crypto.proto.lol.Rq\", haskellPrefix = [], parentModule = [MName \"Crypto\",MName \"Proto\",MName \"Lol\"], baseName = MName \"Rq\"}), hsRawDefault = Nothing, hsDefault = Nothing}], descOneofs = fromList [], keys = fromList [], extRanges = [], knownKeys = fromList [], storeUnknown = False, lazyFields = False, makeLenses = False}"

instance P'.TextType RqProduct where
  tellT = P'.tellSubMessage
  getT = P'.getSubMessage

instance P'.TextMsg RqProduct where
  textPut msg
   = do
       P'.tellT "rqs" (rqs msg)
  textGet
   = do
       mods <- P'.sepEndBy (P'.choice [parse'rqs]) P'.spaces
       Prelude'.return (Prelude'.foldl (\ v f -> f v) P'.defaultValue mods)
    where
        parse'rqs
         = P'.try
            (do
               v <- P'.getT "rqs"
               Prelude'.return (\ o -> o{rqs = P'.append (rqs o) v}))