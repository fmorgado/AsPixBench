package pixbench {
	
	/** Represents the score of a benchmark set. */
	public final class BenchmarkSetScore {
		
		/**
		 * Constructor.
		 * @param  name    The name of the benchmark set.
		 * @param  scores  The scores of the benchmarks.
		 */
		public function BenchmarkSetScore(name:String, scores:Vector.<BenchmarkScore>) {
			_name = name;
			_scores = scores;
		}
		
		private var _name:String;
		/** The name of the benchmark set. */
		public function get name():String { return _name; }
		
		private var _scores:Vector.<BenchmarkScore>;
		/** The benchmark scores. */
		public function get scores():Vector.<BenchmarkScore> { return _scores; }
		
		/** Get a string representation of this instance. */
		public function toString():String {
			var result:String = '####  ' + name + "\n";
			
			// Sort scores
			_scores = _scores.sort(
				function(score1:BenchmarkScore, score2:BenchmarkScore):int {
					return score1.value < score2.value
					? -1 : score1.value == score2.value ? 0 : 1;
				}
			);
			
			var minValue:Number = Number.MAX_VALUE;
			var maxNameLength:int = 0;
			
			const length:uint = _scores.length;
			var index:uint;
			for (index = 0; index < length; index++) {
				const score:BenchmarkScore = _scores[index];
				
				if (score.name.length > maxNameLength)
					maxNameLength = score.name.length;
				
				if (score.value < minValue)
					minValue = score.value;
			}
			
			function getPadding(length:int):String {
				var result:String = '';
				while(length -- > 0)
					result += ' ';
				return result;
			}
			
			maxNameLength += 2;
			for (index = 0; index < length; index++) {
				const sc:BenchmarkScore = scores[index];
				
				var line:String = '      ';
				line += sc.name;
				line += getPadding(maxNameLength - sc.name.length);
				
				const scoreValue:String = sc.value.toFixed(6);
				line += getPadding(14 - scoreValue.length);
				line += scoreValue;
				
				const ratio:String = (sc.value / minValue).toFixed(2);
				line += getPadding(8 - ratio.length);
				line += ratio;
				
				result += line + "\n";
			}
			
			return result;
		}
		
	}
}