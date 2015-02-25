package by.njjnex.logic;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

public class CountArrayList<E> extends ArrayList<E> { 

	    // This is private. It is not visible from outside.
	    private Map<E,Integer> count = new HashMap<E,Integer>();

	    // There are several entry points to this class
	    // this is just to show one of them.
	    public boolean add( E element  ) { 
	        if( !count.containsKey( element ) ){
	            count.put( element, 1 );
	        } else { 
	            count.put( element, count.get( element ) + 1 );
	        }
	        return super.add( element );
	    }

	    // This method belongs to CountItemList interface ( or class ) 
	    // to used you have to cast.
	    public int getCount( E element ) { 
	        if( ! count.containsKey( element ) ) {
	            return 0;
	        }
	        return count.get( element );
	    }
	    public Map<E, Integer> createCountMap(){
	    	return count;
	    }
	  }

