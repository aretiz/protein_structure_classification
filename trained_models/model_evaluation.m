% load the model by double clicking on it and then run the following lines

estim = predict(model,test_mat);

statscm = confusionmatStats(true_label,estim);
acc = statscm.Overall_Accuracy;
