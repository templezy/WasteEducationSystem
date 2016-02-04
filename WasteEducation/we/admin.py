from django.contrib import admin

from .models import Rubbishbin, Waste, Survey, Question, TrueFalseQuestion, WhichBinQuestion, KeepInMindQuestion, Feedback
# Register your models here.

# admin.site.register(Rubbishbin)
# admin.site.register(Waste)
# admin.site.register(Survey)
admin.site.register(Question)
admin.site.register(TrueFalseQuestion)
admin.site.register(WhichBinQuestion)
admin.site.register(KeepInMindQuestion)
admin.site.register(Feedback)


