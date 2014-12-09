package pixbench {
	
	/** Represents the score of a benchmark. */
	public final class BenchmarkScore {
		/**
		 * Constructor.
		 * @param  name   The name of the benchmark.
		 * @param  score  The value of the benchmark score.
		 */
		public function BenchmarkScore(name:String, value:Number) {
			_name = name;
			_value = value;
		}
		
		private var _name:String;
		/** Get the name of the benchmark. */
		public function get name():String { return _name; }
		
		private var _value:Number;
		/** Get the value of the benchmark score. */
		public function get value():Number { return _value; }
		
		/** Get a string representation of this scrore. */
		public function toString():String {
			return _name + '      ' + _value;
		}
	}
}