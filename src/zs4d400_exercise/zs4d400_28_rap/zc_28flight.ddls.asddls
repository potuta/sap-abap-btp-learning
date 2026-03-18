@Metadata.allowExtensions: true
@Metadata.ignorePropagatedAnnotations: true
@Endusertext: {
  Label: '###GENERATED Core Data Service Entity'
}
@Objectmodel: {
  Sapobjectnodetype.Name: 'Z28FLIGHT'
}
@AccessControl.authorizationCheck: #MANDATORY
define root view entity ZC_28FLIGHT
  provider contract TRANSACTIONAL_QUERY
  as projection on ZR_28FLIGHT
  association [1..1] to ZR_28FLIGHT as _BaseEntity on $projection.UUID = _BaseEntity.UUID
{
  key UUID,
  CarrierID,
  ConnectionID,
  AirportFromID,
  CityFrom,
  CountryFrom,
  AirportToID,
  CityTo,
  CountryTo,
  @Semantics: {
    User.Createdby: true
  }
  LocalCreatedBy,
  @Semantics: {
    Systemdatetime.Createdat: true
  }
  LocalCreatedAt,
  @Semantics: {
    User.Localinstancelastchangedby: true
  }
  LocalLastChangedBy,
  @Semantics: {
    Systemdatetime.Localinstancelastchangedat: true
  }
  LocalLastChangedAt,
  @Semantics: {
    Systemdatetime.Lastchangedat: true
  }
  LastChangedAt,
  _BaseEntity
}
