int [][] points = new int[0][0];
int meanX = 0;
int meanY = 0;

void calculateMeans() {
  int sumX = 0;
  int sumY = 0;

  for (int i = 0; i < points.length; i++) {
    sumX += points[i][0];
    sumY += points[i][1];
  };

  meanX = sumX/points.length;
  meanY = sumY/points.length;
};

public float calculateCovariance() {
  float cov = 0;

  for (int i = 0; i < points.length; i++) {
    cov += (points[i][0] - meanX)*(points[i][1] - meanY);
  };

  return cov;
};

public float calculateVariance() {
  float v = 0;

  for (int i = 0; i < points.length; i++) {
    v += pow((points[i][0] - meanX), 2);
  };

  return v;
};

public float[] calculateCoef() {
  float[] coef = new float[2];

  float gradient = calculateCovariance()/calculateVariance();
  float yIntercept = meanY - gradient * meanX;

  coef[0] = gradient;
  coef[1] = yIntercept;

  return coef;
};

void mouseClicked() {
  int [] point = new int[2];

  point[0] = (int) mouseX;
  point[1] = (int) mouseY;

  points = (int[][]) append(points, point);

  calculateMeans();
};

void setup() {
  size(1200, 800);
};

void draw() {
  background(255);
  fill(0);
  noStroke();
  for (int i = 0; i < points.length; i++) {
    circle(points[i][0], points[i][1], 10);
  };

  //y = mx+b
  float[] coefs = calculateCoef();//m,b

  float lineY1 = (coefs[0]*0) + coefs[1];
  float lineY2 = (coefs[0]*width) + coefs[1];
  stroke(255, 0, 0);
  line(0, lineY1, width, lineY2);
};
