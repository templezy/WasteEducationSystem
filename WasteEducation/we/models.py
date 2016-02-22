from __future__ import unicode_literals
from django.db import models

# Create your models here.

#  Test - Delete
class Rubbishbin(models.Model):
    bname_text = models.CharField(max_length=200)

    def __str__(self):
        return self.bname_text

# Test - Delete

class Waste(models.Model):
    rubbishbin = models.ForeignKey(Rubbishbin, on_delete=models.CASCADE)
    wastename_text = models.CharField(max_length=200)
    wcount = models.IntegerField(default=0)

    def __str__(self):
        return self.wastename_text

# Test - Delete

class Survey(models.Model):
    name_text = models.CharField(max_length=200)
    total_score = models.IntegerField(default=0)
    total_times = models.IntegerField(default=0)
    question_order = models.CharField(max_length=500, default="")
    question_count = models.IntegerField(default=0)

# Multiple choices

class Question(models.Model):
    question_text = models.CharField(max_length=200, default="")
    TYPE_CHOICE = {
        ('A', 'Single choice'),
        ('B', 'Multi choice'),
        ('C', 'Image based'),
        ('D', 'Video based'),
    }
    CORRECT_ANSWER = (
        ('A', 'A is the correct answer'),
        ('B', 'B is the correct answer'),
        ('C', 'C is the correct answer'),
        ('D', 'D is the correct answer'),
    )
    question_type = models.CharField(max_length=1, choices=TYPE_CHOICE, default='A')
    img_url = models.CharField(max_length=300, default="", blank=True)
    video_url = models.CharField(max_length=300, default="", blank=True)
    question_desc = models.CharField(max_length=300, default="")
    first_desc = models.CharField(max_length=200, default="")
    second_desc = models.CharField(max_length=200, default="")
    third_desc = models.CharField(max_length=200, default="")
    fourth_desc = models.CharField(max_length=200, default="", blank=True)
    choice = models.CharField(max_length=1, choices=CORRECT_ANSWER, default='A')
    score = models.IntegerField(default=0)
    total_times = models.IntegerField(default=0)

    def __str__(self):
        return self.question_text

# True or False


class TrueFalseQuestion(models.Model):
    question_text = models.CharField(max_length=200, default="")
    TRUE_FALSE = {
        ('TRUE', 'Description is true'),
        ('FALSE', 'Description is false'),
    }
    question_desc = models.CharField(max_length=300, default="")
    question_reason = models.CharField(max_length=500, default="")
    question_choice = models.CharField(max_length=5, choices=TRUE_FALSE, default='TRUE')
    question_score = models.IntegerField(default=0)
    question_total_times = models.IntegerField(default=0)

    def __str__(self):
        return self.question_text


# Shake bin

class WhichBinQuestion(models.Model):
    question_text = models.CharField(max_length=200, default="")
    WASTE_BIN_COLOR = {
        ('RED', 'Should be put into red waste bin'),
        ('YELLOW', 'Should be put into yellow waste bin'),
        ('GREEN', 'Should be put into green waste bin'),
    }
    question_image = models.CharField(max_length=200, default="")
    question_waste_name = models.CharField(max_length=100, default="")
    question_choice = models.CharField(max_length=10, choices=WASTE_BIN_COLOR, default='RED')
    question_score = models.IntegerField(default=0)
    question_total_times = models.IntegerField(default=0)

    def __str__(self):
        return self.question_text

# Brain storm

class KeepInMindQuestion(models.Model):
    question_text = models.CharField(max_length=200, default="")
    question_content = models.CharField(max_length=500, default="")
    question_choice = models.CharField(max_length=20, default="")
    question_score = models.IntegerField(default=0)
    question_total_times = models.IntegerField(default=0)

    def __str__(self):
        return self.question_text


class Test(models.Model):
    m_text = models.CharField(max_length=200)


class Feedback(models.Model):
    feedback_text = models.CharField(max_length=200, default="")
    feedback_content = models.CharField(max_length=300, default="")

    def __str__(self):
        return self.feedback_text

