Class FS.Address Extends (%SerialObject, %Library.Populate)
{

Property Postal As %String;

Property City As %String;

Property Phone As %String;

Storage Default
{
<Data name="AddressState">
<Value name="1">
<Value>Postal</Value>
</Value>
<Value name="2">
<Value>City</Value>
</Value>
<Value name="3">
<Value>Phone</Value>
</Value>
</Data>
<State>AddressState</State>
<StreamLocation>^FS.AddressS</StreamLocation>
<Type>%Storage.Serial</Type>
}

}
