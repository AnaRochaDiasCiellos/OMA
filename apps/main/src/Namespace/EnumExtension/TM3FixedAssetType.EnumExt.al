/// <summary>
/// EnumExtension TM3 FixedAssetType (ID 50300) extends Record Price Asset Type.
/// </summary>
enumextension 50300 "TM3 FixedAssetType" extends "Price Asset Type"
{
    /// <summary>
    /// another summary about an enum extension
    /// </summary>
    value(50300; "TM3 FixedAsset")
    {
        Caption = 'Fixed Asset';
        Implementation = "Price Asset" = "TM3 PriceAsset-FixedAsset";
    }
}