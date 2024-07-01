/// <summary>
/// Codeunit TM3 PriceAsset-FixedAsset (ID 50304) implements Interface Price Asset.
/// </summary>
/// <remarks>a remark about this codeunit 50304</remarks>
codeunit 50304 "TM3 PriceAsset-FixedAsset" implements "Price Asset"
{
    var
        FixedAsset: Record "Fixed Asset";

    procedure GetNo(var PriceAsset: Record "Price Asset")
    begin
        PriceAsset."Table Id" := Database::"Fixed Asset";
        if FixedAsset.GetBySystemId(PriceAsset."Asset ID") then begin
            PriceAsset."Asset No." := FixedAsset."No.";
            FillAdditionalFields(PriceAsset);
        end else
            PriceAsset.InitAsset();
    end;

    procedure GetId(var PriceAsset: Record "Price Asset")
    begin
        PriceAsset."Table Id" := Database::"Fixed Asset";
        if FixedAsset.Get(PriceAsset."Asset No.") then begin
            PriceAsset."Asset ID" := FixedAsset.SystemId;
            FillAdditionalFields(PriceAsset);
        end else
            PriceAsset.InitAsset();
    end;

    procedure IsLookupOK(var PriceAsset: Record "Price Asset"): Boolean
    var
        xPriceAsset: Record "Price Asset";
    begin
        xPriceAsset := PriceAsset;
        if FixedAsset.Get(xPriceAsset."Asset No.") then;
        if Page.RunModal(Page::"Fixed Asset List", FixedAsset) = ACTION::LookupOK then begin
            xPriceAsset.Validate("Asset No.", FixedAsset."No.");
            PriceAsset := xPriceAsset;
            exit(true);
        end;
    end;

    procedure ValidateUnitOfMeasure(var PriceAsset: Record "Price Asset"): Boolean
    begin
    end;

    procedure IsLookupUnitOfMeasureOK(var PriceAsset: Record "Price Asset"): Boolean
    begin
    end;

    procedure IsLookupVariantOK(var PriceAsset: Record "Price Asset"): Boolean
    begin
        exit(false)
    end;

    procedure IsAssetNoRequired(): Boolean;
    begin
        exit(true)
    end;

    procedure FillBestLine(PriceCalculationBuffer: Record "Price Calculation Buffer"; AmountType: Enum "Price Amount Type"; var PriceListLine: Record "Price List Line")
    begin
    end;

    procedure FilterPriceLines(PriceAsset: Record "Price Asset"; var PriceListLine: Record "Price List Line") Result: Boolean;
    begin
        PriceListLine.SetRange("Asset Type", PriceAsset."Asset Type");
        PriceListLine.SetRange("Asset No.", PriceAsset."Asset No.");
    end;

    procedure PutRelatedAssetsToList(PriceAsset: Record "Price Asset"; var PriceAssetList: Codeunit "Price Asset List")
    begin
    end;

    procedure FillFromBuffer(var PriceAsset: Record "Price Asset"; PriceCalculationBuffer: Record "Price Calculation Buffer")
    begin
        PriceAsset.NewEntry(PriceCalculationBuffer."Asset Type", PriceAsset.Level);
        PriceAsset.Validate("Asset No.", PriceCalculationBuffer."Asset No.");
    end;

    local procedure FillAdditionalFields(var PriceAsset: Record "Price Asset")
    begin
        PriceAsset.Description := FixedAsset.Description;
        PriceAsset."Unit of Measure Code" := '';
        PriceAsset."Variant Code" := '';
    end;
}
