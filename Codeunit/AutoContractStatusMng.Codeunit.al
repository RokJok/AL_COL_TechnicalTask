codeunit 50120 "Contract Status Management"
{
    TableNo = "Auto Rent Header";

    trigger OnRun() //Release Contract
    begin
        OnBeforeReleaseContract(Rec);

        Rec."Contract Status" := Rec."Contract Status"::Released;
        Rec.Modify(false);

        OnAfterReleaseContract(Rec);
    end;

    procedure OpenContract(var RentContract: Record "Auto Rent Header") //Open Contract
    begin
        OnBeforeOpenContract(RentContract);

        RentContract."Contract Status" := RentContract."Contract Status"::Open;
        RentContract.Modify(true);

        OnAfterOpenContract(RentContract);
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeReleaseContract(var RentContract: Record "Auto Rent Header")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterReleaseContract(var RentContract: Record "Auto Rent Header")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeOpenContract(var RentContract: Record "Auto Rent Header")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterOpenContract(var RentContract: Record "Auto Rent Header")
    begin
    end;
}

codeunit 50121 "Contract Status Event Sub"
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Contract Status Management", OnBeforeReleaseContract, '', true, true)]
    local procedure OnBeforeReleaseContractEvent(var RentContract: Record "Auto Rent Header") //Used to check if the all the mandatory fields are filled
    begin
        RentContract.TestField("Auto No.");
        RentContract.TestField("Customer No.");
        RentContract.TestField("Reserved From");
        RentContract.TestField("Reserved Until");
        RentContract.TestField("Auto No.");
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Contract Status Management", OnAfterReleaseContract, '', true, true)]
    local procedure OnAfterReleaseContract(var RentContract: Record "Auto Rent Header") //Used to add reservation dates to the reservation table
    var
        ReservationRec: Record "Auto Reservations";
        LastLineNo: Integer;
    begin
        ReservationRec."Auto Number" := RentContract."Auto No.";

        if ReservationRec.FindLast() then begin
            LastLineNo := ReservationRec."Line No." + 1;
        end
        else
            LastLineNo := 1;
        ReservationRec."Line No." := LastLineNo;
        ReservationRec."Client No." := RentContract."Customer No.";
        ReservationRec."Reserved From" := RentContract."Reserved From";
        ReservationRec."Reserved Until" := RentContract."Reserved Until";

        ReservationRec.Insert(true);
        ReservationRec.Modify(true);

    end;
}

