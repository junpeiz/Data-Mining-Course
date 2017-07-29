import math
import cPickle
'''
We can get the distribution of words given spam in spam_train.csv
We can get the distribution of words given ham in ham_train.csv
We can get the test set in ham_test.txt and spam_test.txt
Each line of the file contains file_id \t word_id \t occurence_times \n
'''

# Use spam_distri to store the distribution with respect to spam
with open('spam_train.csv', 'r') as f:
    content = f.readline()
spam_distri = content.split(',')
spam_distri = map(int, spam_distri)
# Use ham_distri to store the distribution with respect to ham
with open('ham_train.csv', 'r') as f:
    content = f.readline()
ham_distri = content.split(',')
ham_distri = map(int, ham_distri)

# Get the probability of spam and ham
P_spam = sum(spam_distri)*1.0/(sum(spam_distri)+sum(ham_distri))
P_ham = 1 - P_spam

# Laplace Smoothing of spam_distri
total = sum(spam_distri) + len(spam_distri)
spam_distri = [(x+1)*1.0/total for x in spam_distri]

# Laplace Smoothing of ham_distri
total = sum(ham_distri) + len(ham_distri)
ham_distri = [(x+1)*1.0/total for x in ham_distri]

# Get the indicative of the SPAM class
# The structure of all_word_map is {word: index}
all_word_map = cPickle.load(open('all_word_map.pkl'))
indic = [x1/x2 for x1, x2 in zip(spam_distri, ham_distri)]
top_ten_index = sorted(range(len(indic)), key=lambda i: indic[i], reverse=True)[:10]
top_ten_word = []
for i in top_ten_index:
    for k,v in all_word_map.iteritems():
        if(v == i):
            top_ten_word.append(k)
            break
print("The words with top-10 highest ratio is:")
print(top_ten_word)


# Test the accuracy of ham email
# Store the info in {file_id: {word_id: occur_time, ...}, {...}, ...}
ham_collect = {}
f = open('ham_test.txt','r')
for line in f:
    line = line[:-1]
    file_id, word_id, occur_time = map(int, line.split('\t'))
    if(file_id not in ham_collect):
        ham_collect[file_id] = {word_id: occur_time}
    else:
        ham_collect[file_id][word_id] = occur_time
f.close()

ham_misclass_num = 0
ham_whole_num = len(ham_collect)
flag = 0
for file_id, temp_dict in ham_collect.iteritems():
    res_p_spam = math.log(P_spam)
    res_p_ham = math.log(P_ham)
    for word_id, occur_time in temp_dict.iteritems():
        res_p_spam += math.log(spam_distri[word_id-1])*occur_time
        res_p_ham += math.log(ham_distri[word_id-1])*occur_time
    if(res_p_spam > res_p_ham):
        ham_misclass_num += 1

# Test the accuracy of spam email
# Store the info in {file_id: {word_id: occur_time, ...}, {...}, ...}
spam_collect = {}
f = open('spam_test.txt','r')
for line in f:
    line = line[:-1]
    file_id, word_id, occur_time = map(int, line.split('\t'))
    if(file_id not in spam_collect):
        spam_collect[file_id] = {word_id: occur_time}
    else:
        spam_collect[file_id][word_id] = occur_time
f.close()

spam_misclass_num = 0
spam_whole_num = len(spam_collect)
for file_id, temp_dict in spam_collect.iteritems():
    res_p_spam = math.log(P_spam)
    res_p_ham = math.log(P_ham)
    for word_id, occur_time in temp_dict.iteritems():
        res_p_spam += math.log(spam_distri[word_id-1])*occur_time
        res_p_ham += math.log(ham_distri[word_id-1])*occur_time
    if(res_p_spam <= res_p_ham):
        spam_misclass_num += 1

print("The whole number of ham is {0} and the misclassified number is {1}, \
    the correct number is {2}".format(ham_whole_num, ham_misclass_num, ham_whole_num-ham_misclass_num))
print("The whole number of spam is {0} and the misclassified number is {1}, \
    the correct number is {2}".format(spam_whole_num, spam_misclass_num, spam_whole_num-spam_misclass_num))
