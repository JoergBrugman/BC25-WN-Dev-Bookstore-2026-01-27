reportextension 50100 "BSB Vendor - List" extends "Vendor - List"
{
    trigger OnPreRendering(var RenderingPayload: JsonObject)
    var
        ProtectionObj: JsonObject;
    begin
        if CurrReport.TargetFormat <> ReportFormat::PDF then
            exit;
        RenderingPayload.Add('version', '1.0.0.0');
        // Protection object mit user- und admin-Kennwort erstellen
        // Wenn admin-Kennwort nicht gesetzt wird, wir das user-Kennwort hierfür verwendet.
        ProtectionObj.Add('user', 'userpwd');
        ProtectionObj.Add('admin', 'adminpwd');
        // Protection object dem rendering payload heinzufügen
        RenderingPayload.Add('protection', ProtectionObj);
    end;
}