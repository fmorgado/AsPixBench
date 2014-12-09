package pixbench {
	import flash.utils.getTimer;
	
	public class Benchmark {
		
		/**
		 * Measure the average time used to run a function.
		 * @param  method       The function to run.
		 * @param  minimumTime  The minimum amount of time to run the function for, in milliseconds.
		 */
		public static function measureFor(method:Function, minimumTime:int):Number {
			var start:int = getTimer();
			var count:uint = 0;
			var elapsed:int;
			do {
				method();
				count++;
				elapsed = getTimer() - start;
			} while (elapsed < minimumTime);
			return elapsed / count;
		}
		
		/**
		 * Constructor.
		 * @param  name  The name of the benchmark.
		 */
		public function Benchmark(name:String) {
			_name = name;
		}
		
		private var _name:String;
		/** Get the name of the benchmark. */
		public final function get name():String { return _name; }
		
		/** The benchmark code. */
		public function run():void {}
		
		/** Setup the benchmark code. Not measured. */
		public function setup():void {}
		
		/** Tear down the benchmark code. Not measured. */
		public function tearDown():void {}
		
		/** Exercise the benchmark. Invokes [run] 10x. */
		public function exercise():void {
			var count:uint = 10;
			while (count-- > 0) run();
		}
		
		/** Measure the score of this benchmark. */
		public final function measure():BenchmarkScore {
			setup();
			// Warmup for at least 100ms. Discard result.
			measureFor(this.run, 100);
			// Run the benchmark for at least 2000ms.
			const result:Number = measureFor(this.exercise, 2000);
			tearDown();
			return new BenchmarkScore(_name, result);
		}
		
		/**
		 * Measure the benchmark score and report it.
		 * @param  emitter  The method to use to emmit the score.
		 *                  If null, <code>trace</code> is used.
		 */
		public final function report(emitter:Function = null):void {
			const result:BenchmarkScore = measure();
			if (emitter == null)
				trace(result);
			else
				emitter(result);
		}
		
	}
}