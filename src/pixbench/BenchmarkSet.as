package pixbench {
	
	/** Represents a set of benchmarks. */
	public class BenchmarkSet {
		private const _benchs:Vector.<Benchmark> = new Vector.<Benchmark>();
		
		/**
		 * Constructor.
		 * @param  name  The name of the benchmark set.
		 */
		public function BenchmarkSet(name:String) {
			_name = name;
		}
		
		private var _name:String;
		/** The name of the benchmark set. */
		public final function get name():String { return _name; }
		
		/**
		 * Add a benchmark to the set.
		 * @param  bench  The benchmark to add.
		 * @return itself.
		 */
		public final function add(bench:Benchmark):BenchmarkSet {
			_benchs[_benchs.length] = bench;
			return this;
		}
		
		/** Measure the benchmark result. */
		public final function measure():BenchmarkSetScore {
			const scores:Vector.<BenchmarkScore> = new Vector.<BenchmarkScore>();
			
			for (var index:int = 0; index < _benchs.length; index++)
				scores[index] = _benchs[index].measure()
			
			return new BenchmarkSetScore(_name, scores);
		}
		
		/**
		 * Measure the benchmark set score and report it.
		 * @param  emitter  The method to use to emmit the score.
		 *                  If null, <code>trace</code> is used.
		 */
		public final function report(emitter:Function = null):void {
			const result:BenchmarkSetScore = measure();
			if (emitter == null)
				trace(result);
			else
				emitter(result);
		}
	}
}