#tag Module
Protected Module JVStringExtensions
	#tag Method, Flags = &h0
		Function contains(extends source as String, searchPattern as string) As Boolean
		  
		  return (source.InStr(searchPattern) <> 0) or _
		  (source.InStr(LowerCase(searchPattern)) <> 0) or _
		  (source.InStr(UpperCase(searchPattern)) <> 0) or _
		  (source.InStr(TitleCase(searchPattern))  <> 0)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function pad(extends stringValue as String, totalLength as Integer, char as String) As String
		  dim charcount as Integer = stringValue.Len
		  dim paddingChar as String = left(char,1)
		  dim numberOfPaddingChars  as Integer = totalLength-charcount
		  dim paddingChars as String = ""
		  
		  for padding as integer = 1 to numberOfPaddingChars
		    paddingChars = paddingChars+paddingChar
		  next
		  
		  Return paddingChars+stringValue
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function quote(unquotedString as String) As String
		  return DOUBLEQUOTE+unquotedString +DOUBLEQUOTE
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function replace(extends source as String, searchPattern as String, replacementPattern as String, useRegex as Boolean) As String
		  if useRegex then
		    dim regex as RegEx = new RegEx
		    regex.SearchPattern = searchPattern
		    regex.ReplacementPattern = replacementPattern
		    regex.Options.ReplaceAllMatches = True
		    
		    Return regex.Replace(source)
		    
		  else
		    return source.replace(searchPattern, replacementPattern)
		    
		  end if
		  
		End Function
	#tag EndMethod


	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  return chr(13)
			End Get
		#tag EndGetter
		CR As String
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  return chr(34)
			End Get
		#tag EndGetter
		DOUBLEQUOTE As String
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  return chr(10)
			End Get
		#tag EndGetter
		LF As String
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  return chr(9)
			End Get
		#tag EndGetter
		Tab As String
	#tag EndComputedProperty


	#tag ViewBehavior
		#tag ViewProperty
			Name="CR"
			Group="Behavior"
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="DOUBLEQUOTE"
			Group="Behavior"
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue="-2147483648"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Left"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="LF"
			Group="Behavior"
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Name"
			Visible=true
			Group="ID"
			Type="String"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Super"
			Visible=true
			Group="ID"
			Type="String"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Tab"
			Group="Behavior"
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Top"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
		#tag EndViewProperty
	#tag EndViewBehavior
End Module
#tag EndModule
