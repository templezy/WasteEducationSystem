# -*- coding: utf-8 -*-
# Generated by Django 1.9 on 2016-01-01 04:53
from __future__ import unicode_literals

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('we', '0006_question_question_desc'),
    ]

    operations = [
        migrations.CreateModel(
            name='Test',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('m_text', models.CharField(max_length=200)),
            ],
        ),
    ]
