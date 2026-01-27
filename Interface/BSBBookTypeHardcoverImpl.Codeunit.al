codeunit 50104 "BSB Book Type Hardcover Impl." implements "BSB Book Type Process"
{
    procedure StartDeployBook()
    begin
        Message('Das Buch wird im Lager gepickt');
    end;

    procedure StartDeliverBook()
    begin
        Message('Mit UPS Premium veresenden');
    end;
}