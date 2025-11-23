from sklearn.linear_model import LinearRegression
import numpy as np

# given data
xi = np.array([1, 2, 3, 4, 5]).reshape(-1, 1)
yi = np.array([1, 2, 2, 4, 4])

# train the model
model = LinearRegression()
model.fit(xi, yi)

# find coefficients
b0 = model.intercept_
b1 = model.coef_[0]

print("Intercept (b0):", b0)
print("Slope (b1):", b1)

# predict for x = 10
x = np.array([[10]])
y_pred = model.predict(x)
print("Predicted y for x=10:", y_pred[0])
