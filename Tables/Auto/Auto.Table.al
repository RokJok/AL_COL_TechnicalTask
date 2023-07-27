table 50123 "Auto"
{
    Caption = 'Vehicle';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Auto Number"; Code[20])
        {
            Caption = 'Vechicle number';
        }
        field(10; "Auto Name"; Code[20])
        {
            Caption = 'Name';
        }
        field(11; "Auto Make"; Code[20])
        {
            Caption = 'Vechicle make';
            TableRelation = "Auto Make";
        }
        field(12; "Auto Model"; Code[20])
        {
            Caption = 'Vechicle model';
            TableRelation = "Auto Model"."Model Code" where("Make Code" = field("Auto Make"));
        }
        field(13; "Model year"; Date)
        {
            Caption = 'Model year';
        }
        field(14; "Insurance date"; Date)
        {
            Caption = 'Insurance expiration date';
        }
        field(15; "Technical Inspection"; Date)
        {
            Caption = 'Technical Inspection expiration date';
        }
        field(16; "Location Code"; Code[10])
        {
            Caption = 'Location code';
            TableRelation = Location;
        }
        field(17; "Rental Program"; Code[20])
        {
            Caption = 'Rental Program';
            TableRelation = Resource;

            trigger OnValidate()
            var
                Rent: Record Resource;
            begin
                if Rent.Get(Rec."Rental Program") then
                    Rec."Rental cost" := Rent."Unit Price";
            end;
        }
        field(18; "Rental cost"; Decimal)
        {
            Caption = 'Rental cost';
        }
    }

    keys
    {
        key(PK1; "Auto Number")
        {
            Clustered = true;
        }
    }

    trigger OnInsert()
    var
        AutoSetup: Record "Auto Setup";
        NoSeriesManagement: Codeunit NoSeriesManagement;
    begin
        if "Auto Number" = '' then begin
            AutoSetup.Get();
            AutoSetup.TestField("Auto Nos");
            "Auto Number" := NoSeriesManagement.GetNextNo(AutoSetup."Auto Nos", WorkDate(), true);
        end;
    end;

}