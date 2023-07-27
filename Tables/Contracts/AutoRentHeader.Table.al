table 50126 "Auto Rent Header"
{
    Caption = 'Vehicle Rent Header';

    fields
    {
        field(1; "Contract No."; Code[20])
        {
            Caption = 'Contract Number';
        }
        field(10; "Customer No."; Code[20])
        {
            Caption = 'Customer Number';
            NotBlank = true;

            TableRelation = Customer;

            trigger OnValidate()
            var
                Customer: Record Customer;
            begin
                if Customer.Get(Rec."Customer No.") then
                    CheckCustomer();
            end;
        }
        field(11; "Drivers Licence"; Media)
        {
            Caption = 'Cutomers Drivers Licence';
            NotBlank = true;
        }
        field(12; "Date"; Date)
        {
            Caption = 'Contract Date';
            NotBlank = true;
        }
        field(13; "Auto No."; Code[20])
        {
            Caption = 'Vehicle Number';
            NotBlank = true;

            TableRelation = Auto;

            trigger OnValidate()
            begin
                AddRentProgramToLine();
            end;
        }
        field(14; "Reserved From"; Date)
        {
            Caption = 'Reserved From';
            NotBlank = true;

            trigger OnValidate()
            var
                BadDateErr: Label '"From" date can not be more than "Until" date';
            begin
                CheckReservations("Reserved From");
                if ("Reserved From" > "Reserved Until") and ("Reserved Until" <> 0D) then
                    Error(BadDateErr);
                if ("Reserved From" <> 0D) and ("Reserved Until" <> 0D) then
                    AddQuantityToLine();
            end;
        }
        field(15; "Reserved Until"; Date)
        {
            Caption = 'Reserved Until';
            NotBlank = true;

            trigger OnValidate()
            var
                BadDateErr: Label '"Until" date can not be less than "From" date';
            begin
                CheckReservations("Reserved Until");
                if ("Reserved From" > "Reserved Until") and ("Reserved From" <> 0D) then
                    Error(BadDateErr);

                if ("Reserved From" <> 0D) and ("Reserved Until" <> 0D) then
                    AddQuantityToLine();
            end;
        }
        field(16; "Total Cost"; Decimal)
        {
            Caption = 'Total Cost';
            Editable = false;

            FieldClass = FlowField;
            CalcFormula =
                sum("Auto Rent Line"."Total Amount"
                    where("Contract No." = field("Contract No.")));

        }
        field(17; "Contract Status"; Enum "Auto Rent Status")
        {
            Caption = 'Contract Status';
            Editable = false;
        }
    }

    keys
    {
        key(PK1; "Contract No.")
        {
            Clustered = true;
        }
    }

    trigger OnInsert()
    begin
        SetContractNumber();
        AddAutoRentLine();
    end;

    local procedure CheckCustomer()
    var
        Customer: Record Customer;
        CustomerLedgerEntry: Record "Cust. Ledger Entry";
        CustomerDebt: Decimal;
        CustomerDebtMsg: Label 'Customer is in debt';
    begin
        if Customer.Get(Rec."Customer No.") then begin
            Customer.TestField(Blocked, Customer.Blocked::" "); //Checking if the customer is not blocked

            CustomerLedgerEntry.SetFilter("Customer No.", Rec."Customer No."); //Checking if the customer is not in debt
            if CustomerLedgerEntry.FindSet() then
                repeat
                    CustomerDebt += CustomerLedgerEntry."Amount (LCY)";
                until CustomerLedgerEntry.Next() = 0;
            if CustomerDebt > 0 then
                Message(CustomerDebtMsg);
        end;

    end;

    local procedure CheckReservations(CurRecDate: Date) //Checks if a vehicle is available on a specific date
    var
        ReservationRec: Record "Auto Reservations";
        BadReservationDateErr: Label 'The vehicle is not available at this date.';
    begin
        ReservationRec.SetFilter("Auto Number", "Auto No.");
        if ReservationRec.FindSet() then
            repeat
                if (ReservationRec."Reserved From" = CurRecDate) or (ReservationRec."Reserved Until" = CurRecDate) then
                    Error(BadReservationDateErr);
                if (ReservationRec."Reserved From" < CurRecDate) and (ReservationRec."Reserved Until" > CurRecDate) then
                    Error(BadReservationDateErr);
            until ReservationRec.Next() = 0;
    end;

    local procedure SetContractNumber() //Takes a number for the contract from a number series
    var
        AutoSetup: Record "Auto Setup";
        NoSeriesManagement: Codeunit NoSeriesManagement;
    begin
        if "Contract No." = '' then begin
            AutoSetup.Get();
            AutoSetup.TestField("Rent Card Nos");
            "Contract No." := NoSeriesManagement.GetNextNo(AutoSetup."Rent Card Nos", WorkDate(), true);
        end;
    end;

    //Following procedures handle the input of date to the first line of the contract
    local procedure AddAutoRentLine() //Adds the first line of the rent contract which has the rent programs info
    var
        RentLine: Record "Auto Rent Line";
    begin
        RentLine."Contract No." := "Contract No.";
        RentLine."Line No." := 1;
        RentLine.Type := RentLine.Type::Resource;

        RentLine.Insert(true);
        RentLine.Modify(true);
    end;

    local procedure AddRentProgramToLine() //Adds the information about the rent program to the line
    var
        RentLine: Record "Auto Rent Line";
        AutoRec: Record Auto;
    begin
        RentLine.Get("Contract No.", 1);
        AutoRec.Get("Auto No.");

        RentLine."Item/Resource No." := AutoRec."Rental Program";
        RentLine.Validate("Item/Resource No.");

        RentLine.Modify(true);
    end;

    local procedure AddQuantityToLine() //Adds the quantity (the number of days the vehicle has been rented for) to the line
    var
        RentLine: Record "Auto Rent Line";
    begin
        RentLine.Get("Contract No.", 1);

        RentLine.Quantity := "Reserved Until" - "Reserved From";
        RentLine.Validate(Quantity);

        RentLine.Modify(true);
    end;

}