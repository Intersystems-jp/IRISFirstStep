Class FS.Person Extends (%Persistent, %Library.Populate)
{

Property Name As %String;

Property Address As FS.Address;

Property Gender As %String(VALUELIST = ",M,F");

Property DOB As %Date;

Property Age As %Integer [ Calculated, ReadOnly, SqlComputeCode = { if {DOB}="" { set {Age}=""}
	else { set {Age}=($zdate($H,8)-$zdate({DOB},8))\10000 }}, SqlComputed ];

Method printGender()
{
	If ..Gender = "M" {
		Write "私は男です"
	}
	Else {
		Write "私は女です"		
	}
}

Method AgeGet() As %Integer
{
	Quit ..calculateAge(..DOB)
}

ClassMethod calculateAge(dob As %Date)
{
	Quit (+$Horolog-dob)\365
}

Query ByName(nm As %String) As %SQLQuery
{
SELECT %ID,Age,DOB,Gender,Name,Address_City,Address_Phone,Address_Postal FROM Person
 WHERE (Name %STARTSWITH :nm)
 ORDER BY Age
}

ClassMethod printByName(name As %String = "イ")
{
	// %New("パッケージ名.クラス名:クエリ名") で実行するクエリを指定
	set rset=##class(%ResultSet).%New("FS.Person:ByName")
	
	/* ClassName、QueryNameプロパティを利用して指定する方法もあります。
	set rset.ClassName="FS.Person"
	set rset.QueryName="ByName"
	*/
	
	// SELECTに%Dateのタイプを持ったDOBを指定しています。
	// RuntimeModeプロパティを利用して、表示変換を行います。（サーバー側のみ）
	set rset.RuntimeMode=1  // 1:ODBC形式
	
	// クエリ時の実行　クエリの引数はExecute()の引数に指定します
	do rset.Execute(name)
	
	// 結果セットの行を移動します。最終行に到達すると0を返します
	while (rset.Next()'=0) {

		// Get("列名") でカラムの値を取得します
		write !,rset.%Get("Name")," - ",rset.%Get("Address_City")
		write " - ",rset.%Get("DOB")," - ",rset.%Get("Gender")

		/*
		// ≪補足≫GetData(カラム番号)　でも取得できます。（1から開始）
		//   GetColumnCount() から結果セット中のカラム数を取得できます
		write !
		for i=1:1:rset.GetColumnCount() {
			write rset.GetData(i)," - "
		}
		*/
	}
	
	//　結果セットの終了
	do rset.Close()
	kill rset
	quit
}

Index NameIdx On Name;

Storage Default
{
<Data name="PersonDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>Name</Value>
</Value>
<Value name="3">
<Value>Address</Value>
</Value>
<Value name="4">
<Value>Gender</Value>
</Value>
<Value name="5">
<Value>DOB</Value>
</Value>
</Data>
<DataLocation>^FS.PersonD</DataLocation>
<DefaultData>PersonDefaultData</DefaultData>
<ExtentSize>10</ExtentSize>
<IdLocation>^FS.PersonD</IdLocation>
<IndexLocation>^FS.PersonI</IndexLocation>
<Property name="%%CLASSNAME">
<Selectivity>100.0000%</Selectivity>
</Property>
<Property name="Address">
<Selectivity>10.0000%,City:12.5000%,Phone:10.0000%,Postal:10.0000%</Selectivity>
</Property>
<Property name="DOB">
<Selectivity>10.0000%</Selectivity>
</Property>
<Property name="Gender">
<Selectivity>50.0000%</Selectivity>
</Property>
<Property name="Name">
<Selectivity>10.0000%</Selectivity>
</Property>
<SQLMap name="IDKEY">
<BlockCount>-4</BlockCount>
</SQLMap>
<StreamLocation>^FS.PersonS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
