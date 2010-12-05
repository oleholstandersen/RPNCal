package dk.holstandersen.rpncal.operators;

import dk.holstandersen.rpncal.RPNOperationException;

public class PiOperator implements NullaryOperator {

	@Override
	public Double calculate() throws RPNOperationException {
		return Math.PI;
	}

}
