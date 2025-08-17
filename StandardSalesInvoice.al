reportextension 50100 DYCEStandardSalesInvoice extends "Standard Sales - Invoice"
{
    dataset
    {
        addfirst(Line)
        {
            dataitem(LineForCurrentPage; Integer)
            {
                DataItemTableView = sorting(Number) where(Number = const(1));
                column(PrintOnCurrentPage; LineForCurrentPage.Number) { }
                column(ItemNoLineForCurrentPage; Line."No.") { }
                column(DescriptionLineForCurrentPage; Line.Description) { }
                column(QuantityLineForCurrentPage; FormattedQuantity) { }
                column(UnitOfMeasureLineForCurrentPage; Line."Unit of Measure") { }
                column(UnitPriceLineForCurrentPage; FormattedUnitPrice)
                {
                    AutoFormatExpression = Line.GetCurrencyCode();
                    AutoFormatType = 2;
                }
                column(LineAmountLineForCurrentPage; FormattedLineAmount)
                {
                    AutoFormatExpression = Line.GetCurrencyCode();
                    AutoFormatType = 1;
                }
                trigger OnPreDataItem()
                begin
                    if Line."Line No." = 20000 then
                        CurrReport.Break();
                end;
            }
            dataitem(LineForNewPage; Integer)
            {
                DataItemTableView = sorting(Number) where(Number = const(1));
                column(PrintOnNewPage; LineForNewPage.Number) { }
                column(ItemNoLineForNewPage; Line."No.") { }
                column(DescriptionLineForNewPage; Line.Description) { }
                column(QuantityLineForNewPage; FormattedQuantity) { }
                column(UnitOfMeasureForNewPage; Line."Unit of Measure") { }
                column(UnitPriceForNewPage; FormattedUnitPrice)
                {
                    AutoFormatExpression = Line.GetCurrencyCode();
                    AutoFormatType = 2;
                }
                column(LineAmountLineForNewPage; FormattedLineAmount)
                {
                    AutoFormatExpression = Line.GetCurrencyCode();
                    AutoFormatType = 1;
                }
                trigger OnPreDataItem()
                begin
                    if Line."Line No." <> 20000 then
                        CurrReport.Break();
                end;
            }
        }
        addafter(ReportTotalsLine)
        {
            dataitem(BlockAfterTotals; Integer)
            {
                DataItemTableView = sorting(Number) where(Number = const(1));
                column(TableTitle; 'Example Table') { }
                dataitem(BlockLineAfterTotals; Integer)
                {
                    DataItemTableView = sorting(Number) where(Number = filter(1 .. 3));
                    column(BlockLineAfterTotalsNumber; BlockLineAfterTotals.Number) { }
                }
                trigger OnPreDataItem()
                begin
                    if not PrintBlockAfterTotals then
                        CurrReport.Break();
                end;

            }
        }
    }
    requestpage
    {
        layout
        {
            addafter(DisplayAdditionalFeeNote)
            {
                field(PrintBlockAfterTotalsField; PrintBlockAfterTotals)
                {
                    ApplicationArea = All;
                    Caption = 'Print Block After Totals';
                }
            }
        }
    }
    rendering
    {
        layout("./PageBreakbeforeSecondLine.docx")
        {
            Type = Word;
            LayoutFile = './PageBreakbeforeSecondLine.docx';
            Caption = 'Page Break before Second Line';
        }
        layout("./PageBreakAfterTotals.docx")
        {
            Type = Word;
            LayoutFile = './PageBreakAfterTotals.docx';
            Caption = 'Page Break after Totals';
        }
    }
    var
        PrintBlockAfterTotals: Boolean;

}