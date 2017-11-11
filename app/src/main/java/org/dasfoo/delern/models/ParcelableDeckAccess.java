/*
 * Copyright (C) 2017 Katarina Sheremet
 * This file is part of Delern.
 *
 * Delern is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * any later version.
 *
 * Delern is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with  Delern.  If not, see <http://www.gnu.org/licenses/>.
 */

package org.dasfoo.delern.models;

import android.os.Parcel;
import android.os.Parcelable;
import android.support.annotation.Nullable;

/**
 * Parcelable wrapper.
 */
public class ParcelableDeckAccess implements Parcelable {
    /**
     * Classes implementing the Parcelable interface must also have a non-null static
     * field called CREATOR of a type that implements the Parcelable.Creator interface.
     * https://developer.android.com/reference/android/os/Parcelable.html
     */
    public static final Parcelable.Creator<ParcelableDeckAccess> CREATOR =
            new Parcelable.Creator<ParcelableDeckAccess>() {
                @Override
                public ParcelableDeckAccess createFromParcel(final Parcel in) {
                    return new ParcelableDeckAccess(in);
                }

                @Override
                public ParcelableDeckAccess[] newArray(final int size) {
                    return new ParcelableDeckAccess[size];
                }
            };

    private final DeckAccess mDeckAccess;

    /**
     * Create a Parcelable wrapper around DeckAccess.
     *
     * @param d DeckAccess.
     */
    public ParcelableDeckAccess(final DeckAccess d) {
        mDeckAccess = d;
    }

    /**
     * Parcelable deserializer.
     *
     * @param in parcel.
     */
    @SuppressWarnings(
            /* Thread class loader is empty during instrumented tests (2 APK in a single process) */
            "PMD.UseProperClassLoader"
    )
    protected ParcelableDeckAccess(final Parcel in) {
        mDeckAccess = new DeckAccess(ParcelableDeck.get(in.readParcelable(
                ParcelableDeckAccess.class.getClassLoader())));
        mDeckAccess.setAccess(in.readString());
    }

    /**
     * Cast parcel to object.
     *
     * @param parcel getParcelableExtra() / readParcelable() return value.
     * @return casted object.
     */
    @Nullable
    public static DeckAccess get(final Object parcel) {
        if (parcel == null) {
            return null;
        }
        return ((ParcelableDeckAccess) parcel).mDeckAccess;
    }

    /**
     * {@inheritDoc}
     */
    @Override
    public int describeContents() {
        return 0;
    }

    /**
     * {@inheritDoc}
     */
    @Override
    public void writeToParcel(final Parcel parcel, final int flags) {
        parcel.writeParcelable(new ParcelableDeck(mDeckAccess.getDeck()), flags);
        parcel.writeString(mDeckAccess.getAccess());
    }
}
