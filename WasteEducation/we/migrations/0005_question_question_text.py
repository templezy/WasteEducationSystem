# -*- coding: utf-8 -*-
# Generated by Django 1.9 on 2015-12-22 01:17
from __future__ import unicode_literals

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('we', '0004_auto_20151222_0102'),
    ]

    operations = [
        migrations.AddField(
            model_name='question',
            name='question_text',
            field=models.CharField(default='', max_length=200),
        ),
    ]