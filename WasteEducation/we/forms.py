from django import forms


class FeedbackForm(forms.Form):
    feedback_content = forms.CharField(label="feedback_content", max_length=300)

