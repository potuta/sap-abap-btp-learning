@Metadata.allowExtensions: true
@Metadata.ignorePropagatedAnnotations: true
@Endusertext: {
  Label: '###GENERATED Core Data Service Entity'
}
@Objectmodel: {
  Sapobjectnodetype.Name: 'Z00GROCERY'
}
@AccessControl.authorizationCheck: #MANDATORY
define root view entity ZC_00GROCERY
  provider contract TRANSACTIONAL_QUERY
  as projection on ZR_00GROCERY
  association [1..1] to ZR_00GROCERY as _BaseEntity on $projection.ID = _BaseEntity.ID
{
  key ID,
  Product,
  Category,
  Brand,
  @Semantics: {
    Amount.Currencycode: 'Currency'
  }
  Price,
  @Consumption: {
    Valuehelpdefinition: [ {
      Entity.Element: 'Currency', 
      Entity.Name: 'I_CurrencyStdVH', 
      Useforvalidation: true
    } ]
  }
  Currency,
  Quantity,
  Purchasedate,
  Expirationdate,
  Expired,
  Rating,
  Note,
  @Semantics: {
    User.Createdby: true
  }
  Createdby,
  Createdat,
  @Semantics: {
    User.Lastchangedby: true
  }
  Lastchangedby,
  @Semantics: {
    Systemdatetime.Lastchangedat: true
  }
  Lastchangedat,
  @Semantics: {
    Systemdatetime.Localinstancelastchangedat: true
  }
  Locallastchanged,
  _BaseEntity
}
