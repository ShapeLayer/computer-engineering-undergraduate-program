package io.github.shapelayer.ElectionResultAnalyzer.models;

public class Struct8Values {
  public float economic;
  public float diplomatic;
  public float civil;
  public float society;

  public Struct8Values(float economic, float diplomatic, float civil, float society) {
    this.economic = economic;
    this.diplomatic = diplomatic;
    this.civil = civil;
    this.society = society;
  }
  
  public Struct8Values() {
    this(0, 0, 0, 0);
  }

  @Override
  public String toString() {
    return String.format("Economic: %.2f, Diplomatic: %.2f, Civil: %.2f, Society: %.2f", 
                         economic, diplomatic, civil, society);
  }
  
  public Struct8Values add(Struct8Values other) {
    return new Struct8Values(
      this.economic + other.economic,
      this.diplomatic + other.diplomatic,
      this.civil + other.civil,
      this.society + other.society
    );
  }

  public Struct8Values sub(Struct8Values other) {
    return new Struct8Values(
      this.economic - other.economic,
      this.diplomatic - other.diplomatic,
      this.civil - other.civil,
      this.society - other.society
    );
  }

  public Struct8Values mul(float factor) {
    return new Struct8Values(
      this.economic * factor,
      this.diplomatic * factor,
      this.civil * factor,
      this.society * factor
    );
  }

  public Struct8Values divide(float divisor) {
    if (divisor == 0) {
      throw new IllegalArgumentException("Divisor cannot be zero");
    }
    return new Struct8Values(
      this.economic / divisor,
      this.diplomatic / divisor,
      this.civil / divisor,
      this.society / divisor
    );
  }
}
