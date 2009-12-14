package asx.array { 

  /**
   * Preserves unique values in an Array, removes any duplicate values. 
   *  
   * @param array Array from which to remove duplicates
   * @return Array of unique items
   * @example
   *  <listing version="3.0">
   *  var values:Array = [1, 1, 1, 2, 3, 5, 5, 8];
   *  var uniq:Array = unique(values);
   *  assertThat(uniq, equalTo([1, 2, 3, 5, 8]));
   *  </listing>
   */
  public function unique(array:Array, field:String=null):Array {
    return field 
      ? inject([], array, uniqueFieldIterator(field)) as Array
      : inject([], array, uniqueIterator) as Array;
  }
}

import asx.array.contains;

internal function uniqueIterator(memo:Array, value:Object):Array {
  if (!contains(memo, value)) {
    memo.push(value);
  }
  return memo;
}

internal function uniqueFieldIterator(field:String):Function
{
  var fieldValues:Array = [];
  return function(memo:Array, value:Object):Array 
  {
    var fieldValue:* = value[field];
    if (!contains(fieldValues, fieldValue))
    {
      fieldValues.push(fieldValue);
      memo.push(value);
    }
    return memo;
  };
}