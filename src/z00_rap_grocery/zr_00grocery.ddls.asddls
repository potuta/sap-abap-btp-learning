@AccessControl.authorizationCheck: #MANDATORY
@Metadata.allowExtensions: true
@ObjectModel.sapObjectNodeType.name: 'Z00GROCERY'
@EndUserText.label: '###GENERATED Core Data Service Entity'
define root view entity ZR_00GROCERY
  as select from z00_grocery as Grocery
{
  key id as ID,
  @Search.defaultSearchElement: false
  product as Product,
  @Search.defaultSearchElement: true
  category as Category,
  @Search.defaultSearchElement: true
  brand as Brand,
  @Semantics.amount.currencyCode: 'Currency'
  price as Price,
  @Consumption.valueHelpDefinition: [ {
    entity.name: 'I_CurrencyStdVH', 
    entity.element: 'Currency', 
    useForValidation: true
  } ]
  currency as Currency,
  quantity as Quantity,
  purchasedate as Purchasedate,
  expirationdate as Expirationdate,
  expired as Expired,
  rating as Rating,
  note as Note,
  @Semantics.user.createdBy: true
  createdby as Createdby,
  createdat as Createdat,
  @Semantics.user.lastChangedBy: true
  lastchangedby as Lastchangedby,
  @Semantics.systemDateTime.lastChangedAt: true
  lastchangedat as Lastchangedat,
  @Semantics.systemDateTime.localInstanceLastChangedAt: true
  locallastchanged as Locallastchanged
}
